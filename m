Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285912B490E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgKPPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:23:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:54886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbgKPPXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:23:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605540191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hXDPxLHhf2Wu81S1L0YOGGDmDdav6QELXVfWLp0Wriw=;
        b=OVr7yeWC1WJ/1YNfjLfTDpzLFPM5irXSm+vTpdhhYWW0gyPttx4RWUmJDusvFHgGnUjA1f
        6B9Q3UEWCc9Hfdns2tdN/wn130OzGduOD18wLIaCKu3fqq2TgVhL4IToyZS54mNBwyfRQD
        XslVTZ7zthwQfSWOk5zXiuWG4F7uhpA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30619AF37;
        Mon, 16 Nov 2020 15:23:11 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: [PATCH 0/4] x86/xen: do some paravirt cleanup
Date:   Mon, 16 Nov 2020 16:22:57 +0100
Message-Id: <20201116152301.24558-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the usergs_sysret64 paravirt call completely and switch
the swapgs one to use ALTERNATIVE instead. This requires to fix the
IST based exception entries for Xen PV to use the same mechanism as
NMI and debug exception already do.

Juergen Gross (4):
  x86/xen: use specific Xen pv interrupt entry for MCE
  x86/xen: use specific Xen pv interrupt entry for DF
  x86/pv: switch SWAPGS to ALTERNATIVE
  x86/xen: drop USERGS_SYSRET64 paravirt call

 arch/x86/entry/entry_64.S             | 32 ++++++++++++---------------
 arch/x86/include/asm/idtentry.h       |  6 +++++
 arch/x86/include/asm/irqflags.h       | 26 +++++++---------------
 arch/x86/include/asm/paravirt.h       | 25 ---------------------
 arch/x86/include/asm/paravirt_types.h | 10 ---------
 arch/x86/kernel/asm-offsets_64.c      |  3 ---
 arch/x86/kernel/paravirt.c            |  6 +----
 arch/x86/kernel/paravirt_patch.c      |  7 ------
 arch/x86/xen/enlighten_pv.c           | 28 ++++++++++++++++++-----
 arch/x86/xen/xen-asm.S                | 24 ++------------------
 arch/x86/xen/xen-ops.h                |  2 --
 11 files changed, 53 insertions(+), 116 deletions(-)

-- 
2.26.2

