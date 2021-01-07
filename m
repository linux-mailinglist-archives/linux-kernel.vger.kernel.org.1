Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602052ED776
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbhAGTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:30:47 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:46097 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610047845; x=1641583845;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+vuYLy41NLSRlJ545SEuo1c5q6mPmv7tXpmCENmeHIA=;
  b=AQRMbZsaKLJ7gyplyp4nX5ayXxuJw8qcehvqJ4VaDvIj+RlafcF1Ob86
   BQZEqIJfsDFHoINnjNvuDQfiOYFfT9SBZ9Lqild211c+7uVP1iCUa9rBZ
   7RS5QsjMz8DIhDO9B71yAECSvmnoUVEWDBJoSU44vQvcI3FouwVVLE/NP
   o=;
X-IronPort-AV: E=Sophos;i="5.79,329,1602547200"; 
   d="scan'208";a="73460932"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Jan 2021 19:30:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 3F04EA20FF;
        Thu,  7 Jan 2021 19:30:03 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 Jan 2021 19:30:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 Jan 2021 19:30:03 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 7 Jan 2021 19:30:02 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 031A7DE122; Thu,  7 Jan 2021 19:30:01 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2] module: harden ELF info handling
Date:   Thu, 7 Jan 2021 19:30:01 +0000
Message-ID: <20210107193001.12039-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5fdc7db644 ("module: setup load info before module_sig_check()")
moved the ELF setup, so that it was done before the signature
check. This made the module name available to signature error
messages.

However, the checks for ELF correctness in setup_load_info
are not sufficient to prevent bad memory references due to
corrupted offset fields, indices, etc.

So, there's a regression in behavior here: a corrupt and unsigned
(or badly signed) module, which might previously have been rejected
immediately, can now cause an oops/crash.

Harden ELF handling for module loading by doing the following:

- Move the signature check back up so that it comes before ELF
  initialization. It's best to do the signature check to see
  if we can trust the module, before using the ELF structures
  inside it. This also makes checks against info->len
  more accurate again, as this field will be reduced by the
  length of the signature in mod_check_sig().

  The module name is now once again not available for error
  messages during the signature check, but that seems like
  a fair tradeoff.

- Check if sections have offset / size fields that at least don't
  exceed the length of the module.

- Check if sections have section name offsets that don't fall
  outside the section name table.

- Add a few other sanity checks against invalid section indices,
  etc.

This is not an exhaustive consistency check, but the idea is to
at least get through the signature and blacklist checks without
crashing because of corrupted ELF info, and to error out gracefully
for most issues that would have caused problems later on.

Fixes: 5fdc7db644 ("module: setup load info before module_sig_check()")
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 kernel/module.c           | 143 ++++++++++++++++++++++++++++++++++++++++------
 kernel/module_signature.c |   2 +-
 kernel/module_signing.c   |   2 +-
 3 files changed, 126 insertions(+), 21 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..34fc6c85eb65 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2964,7 +2964,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	}
 
 	if (is_module_sig_enforced()) {
-		pr_notice("%s: loading of %s is rejected\n", info->name, reason);
+		pr_notice("Loading of %s is rejected\n", reason);
 		return -EKEYREJECTED;
 	}
 
@@ -2977,9 +2977,33 @@ static int module_sig_check(struct load_info *info, int flags)
 }
 #endif /* !CONFIG_MODULE_SIG */
 
-/* Sanity checks against invalid binaries, wrong arch, weird elf version. */
-static int elf_header_check(struct load_info *info)
+static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
+	unsigned long secend;
+
+	/*
+	 * Check for both overflow and offset/size being
+	 * too large.
+	 */
+	secend = shdr->sh_offset + shdr->sh_size;
+	if (secend < shdr->sh_offset || secend > info->len)
+		return -ENOEXEC;
+
+	return 0;
+}
+
+/*
+ * Sanity checks against invalid binaries, wrong arch, weird elf version.
+ *
+ * Also do basic validity checks against section offsets and sizes, the
+ * section name string table, and the indices used for it (sh_name).
+ */
+static int elf_validity_check(struct load_info *info)
+{
+	unsigned int i;
+	Elf_Shdr *shdr, *strhdr;
+	int err;
+
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
@@ -2989,11 +3013,78 @@ static int elf_header_check(struct load_info *info)
 	    || info->hdr->e_shentsize != sizeof(Elf_Shdr))
 		return -ENOEXEC;
 
+	/*
+	 * e_shnum is 16 bits, and sizeof(Elf_Shdr) is
+	 * known and small. So e_shnum * sizeof(Elf_Shdr)
+	 * will not overflow unsigned long on any platform.
+	 */
 	if (info->hdr->e_shoff >= info->len
 	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
 		info->len - info->hdr->e_shoff))
 		return -ENOEXEC;
 
+	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
+
+	/*
+	 * Verify if the section name table index is valid.
+	 */
+	if (info->hdr->e_shstrndx == SHN_UNDEF
+	    || info->hdr->e_shstrndx >= info->hdr->e_shnum)
+		return -ENOEXEC;
+
+	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
+	err = validate_section_offset(info, strhdr);
+	if (err < 0)
+		return err;
+
+	/*
+	 * The section name table must be NUL-terminated, as required
+	 * by the spec. This makes strcmp and pr_* calls that access
+	 * strings in the section safe.
+	 */
+	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (info->secstrings[strhdr->sh_size - 1] != '\0')
+		return -ENOEXEC;
+
+	/*
+	 * The code assumes that section 0 has a length of zero and
+	 * an addr of zero, so check for it.
+	 */
+	if (info->sechdrs[0].sh_type != SHT_NULL
+	    || info->sechdrs[0].sh_size != 0
+	    || info->sechdrs[0].sh_addr != 0)
+		return -ENOEXEC;
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		shdr = &info->sechdrs[i];
+		switch (shdr->sh_type) {
+		case SHT_NULL:
+		case SHT_NOBITS:
+			continue;
+		case SHT_SYMTAB:
+			if (shdr->sh_link == SHN_UNDEF
+			    || shdr->sh_link >= info->hdr->e_shnum)
+				return -ENOEXEC;
+			fallthrough;
+		default:
+			err = validate_section_offset(info, shdr);
+			if (err < 0) {
+				pr_err("Invalid ELF section in module (section %u type %u)\n",
+					i, shdr->sh_type);
+				return err;
+			}
+
+			if (shdr->sh_flags & SHF_ALLOC) {
+				if (shdr->sh_name >= strhdr->sh_size) {
+					pr_err("Invalid ELF section name in module (section num %u type %u)\n",
+					       i, shdr->sh_type);
+					return -ENOEXEC;
+				}
+			}
+			break;
+		}
+	}
+
 	return 0;
 }
 
@@ -3095,11 +3186,6 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		Elf_Shdr *shdr = &info->sechdrs[i];
-		if (shdr->sh_type != SHT_NOBITS
-		    && info->len < shdr->sh_offset + shdr->sh_size) {
-			pr_err("Module len %lu truncated\n", info->len);
-			return -ENOEXEC;
-		}
 
 		/*
 		 * Mark all sections sh_addr with their address in the
@@ -3133,11 +3219,6 @@ static int setup_load_info(struct load_info *info, int flags)
 {
 	unsigned int i;
 
-	/* Set up the convenience variables */
-	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
-	info->secstrings = (void *)info->hdr
-		+ info->sechdrs[info->hdr->e_shstrndx].sh_offset;
-
 	/* Try to find a name early so we can log errors with a module name */
 	info->index.info = find_sec(info, ".modinfo");
 	if (info->index.info)
@@ -3894,26 +3975,50 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	long err = 0;
 	char *after_dashes;
 
-	err = elf_header_check(info);
+	/*
+	 * Do the signature check (if any) first. All that
+	 * the signature check needs is info->len, it does
+	 * not need any of the section info. That can be
+	 * set up later. This will minimize the chances
+	 * of a corrupt module causing problems before
+	 * we even get to the signature check.
+	 *
+	 * The check will also adjust info->len by stripping
+	 * off the sig length at the end of the module, making
+	 * checks against info->len more correct.
+	 */
+	err = module_sig_check(info, flags);
+	if (err)
+		goto free_copy;
+
+	/*
+	 * Do basic sanity checks against the ELF header and
+	 * sections.
+	 */
+	err = elf_validity_check(info);
 	if (err) {
-		pr_err("Module has invalid ELF header\n");
+		pr_err("Module has invalid ELF structures\n");
 		goto free_copy;
 	}
 
+	/*
+	 * Everything checks out, so set up the section info
+	 * in the info structure.
+	 */
 	err = setup_load_info(info, flags);
 	if (err)
 		goto free_copy;
 
+	/*
+	 * Now that we know we have the correct module name, check
+	 * if it's blacklisted.
+	 */
 	if (blacklisted(info->name)) {
 		err = -EPERM;
 		pr_err("Module %s is blacklisted\n", info->name);
 		goto free_copy;
 	}
 
-	err = module_sig_check(info, flags);
-	if (err)
-		goto free_copy;
-
 	err = rewrite_section_headers(info, flags);
 	if (err)
 		goto free_copy;
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index 4224a1086b7d..00132d12487c 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -25,7 +25,7 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 		return -EBADMSG;
 
 	if (ms->id_type != PKEY_ID_PKCS7) {
-		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
+		pr_err("%s: not signed with expected PKCS#7 message\n",
 		       name);
 		return -ENOPKG;
 	}
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 9d9fc678c91d..9a057c5d1d4d 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -30,7 +30,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
 
-	ret = mod_check_sig(&ms, modlen, info->name);
+	ret = mod_check_sig(&ms, modlen, info->name ?: "module");
 	if (ret)
 		return ret;
 
-- 
2.16.6

