Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA82149D1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 05:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGEDXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 23:23:08 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42856 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728134AbgGEDXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:23:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BEFF98EE12E;
        Sat,  4 Jul 2020 20:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593919387;
        bh=hvwML/qk7j/LDv4jikG6wAaRn8p7ch1lsOGpjbuXuaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=topv1XwfJJxfkEaSqNL26bC/8ZxwsuUu7DSPUbEH8jTLBvk2S+eqrPAhYVeETyCMI
         dfzbPBsURGFpr/SwEqlhcVc+QvyQNJKVj2vAQAvGKrXELbSGqbXWiITvPoJPyf0ob+
         gqErXaVmRVSFDBswsbUfdXdhP6GW/cZOf49smMzo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HoBB9uIwWM0p; Sat,  4 Jul 2020 20:23:07 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3EBA48EE07B;
        Sat,  4 Jul 2020 20:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593919387;
        bh=hvwML/qk7j/LDv4jikG6wAaRn8p7ch1lsOGpjbuXuaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=topv1XwfJJxfkEaSqNL26bC/8ZxwsuUu7DSPUbEH8jTLBvk2S+eqrPAhYVeETyCMI
         dfzbPBsURGFpr/SwEqlhcVc+QvyQNJKVj2vAQAvGKrXELbSGqbXWiITvPoJPyf0ob+
         gqErXaVmRVSFDBswsbUfdXdhP6GW/cZOf49smMzo=
Message-ID: <1593919384.7058.22.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dave Airlie <airlied@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Date:   Sat, 04 Jul 2020 20:23:04 -0700
In-Reply-To: <CAPM=9txud3xg+++205X9s9R5wnxobpNSJWLUu=bp8BOhnX_8hQ@mail.gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20200705064348.71d4d51f@canb.auug.org.au>
         <CAPM=9txOgRYc7RM3fzohB4=Ejcp_xMGLBX_OOCOD=r+W6D678A@mail.gmail.com>
         <20200705121216.2ce2dd46@canb.auug.org.au>
         <CAPM=9txud3xg+++205X9s9R5wnxobpNSJWLUu=bp8BOhnX_8hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-05 at 12:56 +1000, Dave Airlie wrote:
> On Sun, 5 Jul 2020 at 12:12, Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
[...]
> > > As for the non-black slavery, others have never pointed this out
> > 
> > (I did not say "non-black")
> > 
> 
> Sorry I misdirected what you said a bit, and I did misinterpret as
> Australia also has it's own indigenous slavery issues,
> 
> I was trying to stop the "white slavery" is a thing crew from turning
> up on this.
> 
> Apologies for accidentally implying something what you hadn't said.

Not at all, thank you; you just gave a precise illustration of my
point: putting statements like this in the kernel acts as a magnet for
this type of disagreement ... and not just from honourable people. 
Developers can honestly disagree about this sort of thing, while
supporting the aim of using inclusive language.  That's why this file
shouldn't be in the kernel tree.

James
