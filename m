Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2E2E0323
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLVAAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:00:16 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:2451 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608595215; x=1640131215;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=n4zZ1T/Tr5kCBJD1hu2zXBWKv3cBaG/ZAjwQm7l2+0M=;
  b=B3xhQoxTyx4c9C6kzLq6XoKXEDGd1lvi7u430cJqEjnPpYSLLa5T4fld
   UAP3/jfDr1Zt00Orfh+K9VDAbNYMmY4skfZgBjR82xmYw1j9CzcsOloBf
   jvqlG+WyFPABd37q0bHfN/FHBKoFHWCQ4DMNjgmkPEmFt0eeE64mrHbKD
   Q=;
X-IronPort-AV: E=Sophos;i="5.78,437,1599523200"; 
   d="scan'208";a="105137219"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 21 Dec 2020 23:59:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 17B85120DCF;
        Mon, 21 Dec 2020 23:56:31 +0000 (UTC)
Received: from EX13D37UEA002.ant.amazon.com (10.43.61.46) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 21 Dec 2020 23:56:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D37UEA002.ant.amazon.com (10.43.61.46) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 21 Dec 2020 23:56:30 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 21 Dec 2020 23:56:30 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 448DCC13AC; Mon, 21 Dec 2020 23:56:30 +0000 (UTC)
Date:   Mon, 21 Dec 2020 23:56:30 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: harden ELF info handling
Message-ID: <20201221235629.GA31184@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201221234921.31129-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201221234921.31129-1-fllinden@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tested this patch by writing a little ELF corruption program that messes
up ELF sections, especially those that are accessed early, in various ways.
With the patch, I could no longer cause any problems with corrupted modules.

In the patch I sent in, I moved the signature back up, so that it's done
before any ELF section parsing. This seemed like the best thing to do -
first see if a module can be trusted at all, and only then parse its
ELF sections. That comes at the price of not having the module name available
for error messages during the sig check, but I think that's ok.

However, if there's disagreement on that, here is a different version that
only hardens the ELF check, and does not change the order otherwise. I can
send it in seperately if needed.

- Frank

========

5fdc7db644 ("module: setup load info before module_sig_check()")
moved the ELF setup, so that it was done before the signature
check. This made the module name available to signature error
messages.

However the ELF validity checks are not enough to prevent a
module with corrupted ELF info from causing a bad memory
reference before the signature and blacklist checks are done.

Harden ELF handling for module loading by doing the following:

- Check if sections have offset / size fields that at least don't
  exceed the length of the module or don't overflow.

- Check if sections have section name offsets that don't fall
  outside the section name table.

- Add a few other sanity checks against invalid section indices,
  etc.

This is not an exhaustive consistency check, but the idea is to
at least safely retrieve the name and get through the signature
and blacklist checks without crashing because of corrupted ELF info.
This should also make things error out more gracefully for most issues
that would have caused problems later on.

Fixes: 5fdc7db644 ("module: setup load info before module_sig_check()")
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 kernel/module.c | 109 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 14 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..5d9b336d1952 100644
--- a/kernel/module.c
+++ b/kernel/module.c
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
+	if (secend < shdr->sh_offset || secend >= info->len)
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
+				pr_debug("Invalid ELF section in module num %u type %u\n",
+					i, shdr->sh_type);
+				return err;
+			}
+
+			if (shdr->sh_flags & SHF_ALLOC) {
+				if (shdr->sh_name >= strhdr->sh_size) {
+					pr_debug("Invalid ELF section name in module num %u type %u\n",
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
@@ -3894,9 +3975,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	long err = 0;
 	char *after_dashes;
 
-	err = elf_header_check(info);
+	err = elf_validity_check(info);
 	if (err) {
-		pr_err("Module has invalid ELF header\n");
+		pr_err("Module has invalid ELF structures\n");
 		goto free_copy;
 	}
 
-- 
2.23.3

