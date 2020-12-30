Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D332E7747
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 10:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgL3JBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 04:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgL3JBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 04:01:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB1920784;
        Wed, 30 Dec 2020 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609318855;
        bh=VGbxPk1NisiSqYxd4Nqxce4ZFoGBlCOFkyUjPMIVssA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nQBQP3ctDgLy6CjpvBdtIY0Kh9GgbLeT50ysY1W49r0Xb/zCIlUNJ0wTo/vAf8TPa
         JfPHizDur9486FXFWv9nrfmDTwr2qWB07V0+70ScowvXeimWBV6UCiVqINve+9x1Fo
         rx2O+Ew54kL697mCGKGgbjBEQOuFkoP7mFdw+ty2vcK3CVrp87kYbDjWRTAiWzaqdZ
         FL6IxmB2oMQ64KbSQkFDIoyFOE0aVp+fJT3se29XfvfWWD1w5nIkhw5wDNvgM05vqO
         1kvugbn/094NF2O24i3gPftqvT4/zxjMrex6ijS7cln56STbr9mHFkjSF1fLGU01Ps
         Nfp2Bob37kq9w==
Date:   Wed, 30 Dec 2020 18:00:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/19] x86/insn: Add an insn_decode() API
Message-Id: <20201230180052.7e1931b4e1b17079023b65b7@kernel.org>
In-Reply-To: <20201229200654.GF29947@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
        <20201223174233.28638-4-bp@alien8.de>
        <20201228101510.49082d470ed328d81486ef04@kernel.org>
        <20201229200654.GF29947@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Dec 2020 21:06:54 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Dec 28, 2020 at 10:15:10AM +0900, Masami Hiramatsu wrote:
> > BTW, insn_decode() can return -EINVAL if !insn_complete(), is that OK?
> 
> It does with this change. Or are you asking whether it returning -EINVAL
> in that case is ok?
> 
> I don't see why not - this way callers can differentiate where it failed
> - at fetching bytes with -ENODATA or it wasn't decoded completely -
> -EINVAL.

Ah, I got it.

> 
> > I think tools clone code must not use INSN_MODE_KERN because the tools may
> > not use kernel Kconfig.
> > 
> > Hmm, this may be better to make a different patch to introduce a NOSYNC tag
> > for sync checker in the tools. Something like;
> 
> I'd actually prefer this:
> 
> diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
> index f8772b371452..545320c67855 100644
> --- a/tools/arch/x86/include/asm/insn.h
> +++ b/tools/arch/x86/include/asm/insn.h
> @@ -98,8 +98,6 @@ extern int insn_get_length(struct insn *insn);
>  enum insn_mode {
>         INSN_MODE_32,
>         INSN_MODE_64,
> -       /* Mode is determined by the current kernel build. */
> -       INSN_MODE_KERN,
>         INSN_NUM_MODES,
>  };

Agreed. This is much simpler.
Maybe I need to replace it with dummy lines but it is possible.

>  
> 
> so that when a tool does use INSN_MODE_KERN, it would fail building:
> 
> In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
> util/intel-pt-decoder/../../../arch/x86/lib/insn.c: In function ‘insn_decode’:
> util/intel-pt-decoder/../../../arch/x86/lib/insn.c:751:11: error: ‘INSN_MODE_KERN’ undeclared (first use in this function); did you mean ‘INSN_MODE_64’?
>   751 |  if (m == INSN_MODE_KERN)
>       |           ^~~~~~~~~~~~~~
>       |           INSN_MODE_64

This part is OK. I can replace it with dummy lines.

> util/intel-pt-decoder/../../../arch/x86/lib/insn.c:751:11: note: each undeclared identifier is reported only once for each function it appears in
>   LD       arch/perf-in.o
> util/intel-pt-decoder/intel-pt-insn-decoder.c: In function ‘intel_pt_get_insn’:
> util/intel-pt-decoder/intel-pt-insn-decoder.c:163:37: error: ‘INSN_MODE_KERN’ undeclared (first use in this function); did you mean ‘INSN_MODE_64’?
>   163 |  ret = insn_decode(&insn, buf, len, INSN_MODE_KERN);
>       |                                     ^~~~~~~~~~~~~~
>       |                                     INSN_MODE_64

But in [17/19], your patch seems not using INSN_MODE_KERN there.

--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -158,11 +158,13 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 		      struct intel_pt_insn *intel_pt_insn)
 {
 	struct insn insn;
+	int ret;
 
-	insn_init(&insn, buf, len, x86_64);
-	insn_get_length(&insn);
-	if (!insn_complete(&insn) || insn.length > len)
+	ret = insn_decode(&insn, buf, len,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0 || insn.length > len)
 		return -1;
+
 	intel_pt_insn_decoder(&insn, intel_pt_insn);
 	if (insn.length < INTEL_PT_INSN_BUF_SZ)
 		memcpy(intel_pt_insn->buf, buf, insn.length);

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
