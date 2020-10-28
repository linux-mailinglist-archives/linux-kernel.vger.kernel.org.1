Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CD29D7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbgJ1W1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:27:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54180 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbgJ1W0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:50 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5442520B4905;
        Wed, 28 Oct 2020 08:42:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5442520B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603899723;
        bh=RuHwBDtrFdBWyPPpOGiNfqJEWL0U014nGRONyTyTrXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAHNQSRkwaz/gwvGl7IRuudfaM7WbOvfWRsEVRhbZGZMy1mLYHyWB4IvZNLPPtmgh
         Sbai+dR9gpdfBo7ILBmvZhTDZMX5v8yzJafETeeKrJk1NeFS1bC1uir23L2Wkrw5Pq
         Uc1fqSAkp9A+3pmUyOR36gAfr2/vF8Kza7komIm8=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] tpm: efi: Don't create binary_bios_measurements file for an empty log
Date:   Wed, 28 Oct 2020 10:41:02 -0500
Message-Id: <20201028154102.9595-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimic the pre-existing ACPI and Device Tree event log behavior by not
creating the binary_bios_measurements file when the EFI TPM event log is
empty.

This fixes the following NULL pointer dereference that can occur when
reading /sys/kernel/security/tpm0/binary_bios_measurements after the
kernel received an empty event log from the firmware:

 BUG: kernel NULL pointer dereference, address: 000000000000002c
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 2 PID: 3932 Comm: fwupdtpmevlog Not tainted 5.9.0-00003-g629990edad62 #17
 Hardware name: LENOVO 20LCS03L00/20LCS03L00, BIOS N27ET38W (1.24 ) 11/28/2019
 RIP: 0010:tpm2_bios_measurements_start+0x3a/0x550
 Code: 54 53 48 83 ec 68 48 8b 57 70 48 8b 1e 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 48 8b 82 c0 06 00 00 48 8b 8a c8 06 00 00 <44> 8b 60 1c 48 89 4d a0 4c 89 e2 49 83 c4 20 48 83 fb 00 75 2a 49
 RSP: 0018:ffffa9c901203db0 EFLAGS: 00010246
 RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000010
 RDX: ffff8ba1eb99c000 RSI: ffff8ba1e4ce8280 RDI: ffff8ba1e4ce8258
 RBP: ffffa9c901203e40 R08: ffffa9c901203dd8 R09: ffff8ba1ec443300
 R10: ffffa9c901203e50 R11: 0000000000000000 R12: ffff8ba1e4ce8280
 R13: ffffa9c901203ef0 R14: ffffa9c901203ef0 R15: ffff8ba1e4ce8258
 FS:  00007f6595460880(0000) GS:ffff8ba1ef880000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000002c CR3: 00000007d8d18003 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? __kmalloc_node+0x113/0x320
  ? kvmalloc_node+0x31/0x80
  seq_read+0x94/0x420
  vfs_read+0xa7/0x190
  ksys_read+0xa7/0xe0
  __x64_sys_read+0x1a/0x20
  do_syscall_64+0x37/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

In this situation, the bios_event_log pointer in the tpm_bios_log struct
was not NULL but was equal to the ZERO_SIZE_PTR (0x10) value. This was
due to the following kmemdup() in tpm_read_log_efi():

int tpm_read_log_efi(struct tpm_chip *chip)
{
...
	/* malloc EventLog space */
	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
	if (!log->bios_event_log) {
		ret = -ENOMEM;
		goto out;
	}
...
}

When log_size is zero, due to an empty event log from firmware,
ZERO_SIZE_PTR is returned from kmemdup(). Upon a read of the
binary_bios_measurements file, the tpm2_bios_measurements_start()
function does not perform a ZERO_OR_NULL_PTR() check on the
bios_event_log pointer before dereferencing it.

Rather than add a ZERO_OR_NULL_PTR() check in functions that make use of
the bios_event_log pointer, simply avoid creating the
binary_bios_measurements_file as is done in other event log retrieval
backends.

Explicitly ignore all of the events in the final event log when the main
event log is empty. The list of events in the final event log cannot be
accurately parsed without referring to the first event in the main event
log (the event log header) so the final event log is useless in such a
situation.

Fixes: 58cc1e4faf10 ("tpm: parse TPM event logs based on EFI table")
Link: https://lore.kernel.org/linux-integrity/E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com/
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Thiébaud Weksteen <tweek@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/char/tpm/eventlog/efi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 6bb023de17f1..35229e5143ca 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -41,6 +41,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	log_size = log_tbl->size;
 	memunmap(log_tbl);
 
+	if (!log_size) {
+		pr_warn("UEFI TPM log area empty\n");
+		return -EIO;
+	}
+
 	log_tbl = memremap(efi.tpm_log, sizeof(*log_tbl) + log_size,
 			   MEMREMAP_WB);
 	if (!log_tbl) {

base-commit: ed8780e3f2ecc82645342d070c6b4e530532e680
-- 
2.25.1

