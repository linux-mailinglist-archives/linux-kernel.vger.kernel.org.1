Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41311BB8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgD1ITa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 04:19:30 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:46142 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD1ITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:19:30 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jTLSe-0000hZ-Rq; Tue, 28 Apr 2020 10:19:24 +0200
Date:   Tue, 28 Apr 2020 10:19:24 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: boot failure: stack-protector: Kernel stack is corrupted in:
 start_secondary
Message-ID: <20200428081924.GA2642@angband.pl>
References: <20200421013234.GA5393@angband.pl>
 <20200428074527.GA12579@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428074527.GA12579@zn.tnic>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:45:27AM +0200, Borislav Petkov wrote:
> On Tue, Apr 21, 2020 at 03:32:34AM +0200, Adam Borowski wrote:
> > Hi!
> > With kernels compiled with gcc-10, on two different machines (AMD Phenom2,
> > AMD 2990WX) I get the following panic during boot:
> 
> Welcome to the party:
> 
> https://git.kernel.org/tip/f670269a42bfdd2c83a1118cc3d1b475547eac22
> 
> Try this branch to check whether it works for ya:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/build

✓


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
