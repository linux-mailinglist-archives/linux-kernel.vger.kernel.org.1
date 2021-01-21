Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079CD2FE500
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbhAUI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhAUI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:28:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C9F23976;
        Thu, 21 Jan 2021 08:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611217660;
        bh=9GHkPoKU7YkckCkJQxzTRA5qEkvV7woYB8UWDbqK4WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMqrrIxrCL45N1tcR6tvsdCmNnpPN0fNoTXIimsYg/R6Z8nPAxWiEIpPTMG5HtXC6
         /PEAp1uc+eG3eCxqmm99YnWS2gM4bM2Cywoyx4BTdwBuUyi3mLVcdhGNYBkx/nkuoR
         4RhQp+tSU9MQvKRVzNY+RutuFdeV2Su2CIJfe88A=
Date:   Thu, 21 Jan 2021 09:27:37 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "ricky_wu@realtek.corp-partner.google.com" 
        <ricky_wu@realtek.corp-partner.google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "levinale@google.com" <levinale@google.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtsx: pci: fix device aspm state bug
Message-ID: <YAk6+ZgNPQy3snB1@kroah.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
 <8563fc3264ad4f46bfa05a3cbdb7d644@realtek.com>
 <YAk2NtOqIohpBJIt@kroah.com>
 <46473ff62a284bf1bdb703e13884beac@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46473ff62a284bf1bdb703e13884beac@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:15:46AM +0000, 吳昊澄 Ricky wrote:
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Thursday, January 21, 2021 4:07 PM
> > To: 吳昊澄 Ricky <ricky_wu@realtek.com>
> > Cc: arnd@arndb.de; ricky_wu@realtek.corp-partner.google.com;
> > sashal@kernel.org; levinale@google.com; keitasuzuki.park@sslab.ics.keio.ac.jp;
> > kdlnx@doth.eu; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] rtsx: pci: fix device aspm state bug
> > 
> > On Thu, Jan 21, 2021 at 07:33:03AM +0000, 吳昊澄 Ricky wrote:
> > > Hi Greg kh,
> > >
> > > This patch to fix misc: rtsx bug for kernel 5.4
> > 
> > I do not understand what this means, sorry.  Can you please explain it?
> > 
> On the newest upstream we don’t set config space for en/disable aspm, 
> so it will not happen this issue
> but on kernel 5.4 longterm version we need to fix it

Please read
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to submit patches to the stable tree properly.

And if this is not an issue in Linus's tree, why not just backport the
commits that fixed this issue?  That's the best way to do this.

thanks,

greg k-h
