Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2327C253
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgI2KYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2KYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:24:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35292076A;
        Tue, 29 Sep 2020 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601375090;
        bh=pchBtxfISE/wCym8h42pDOZ5DqiOc1ZqjONMxC0swIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4l13kRcluZ3Fwxae2U08F0y1EUdSbDNl7CA7RXe5cpAm0Zu2bVp33U2ulvmt5SuX
         PwWgkXULPdpt1ty1nXBsb2qja9BXviFsF1VdYESy84r5lUFl1EjiXVmD0rLdpkd8iv
         4BxF0YBKuGs2fDPywOfYaP9becf4Lv5gmOosOnds=
Date:   Tue, 29 Sep 2020 12:24:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v3 2/3] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200929102455.GA951772@kroah.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-3-scott.branden@broadcom.com>
 <20200907125530.GC2371705@kroah.com>
 <767f6b6a-07fc-f1b6-f43c-b974761f1505@broadcom.com>
 <20200924050851.GA271310@kroah.com>
 <8ce85527-cb0a-7cf4-541b-b346e060e772@broadcom.com>
 <830c5d91-eb45-8569-fc91-19b5b43cbcd7@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <830c5d91-eb45-8569-fc91-19b5b43cbcd7@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:22:12PM -0700, Scott Branden wrote:
> 
> 
> On 2020-09-24 2:40 p.m., Scott Branden wrote:
> > Hi Greg,
> >
> > Responses below.  I'll send out the split up patches hopefully today/tomorrow
> > which may make it a bit easier to understand/comment on.
> >
> >
> I have split up the patches and sent out patch v4.
> Hopefully this is more understandable split up and you understand the rationale for
> a misc driver and a tty driver to support this PCIe card.

I still don't, but I'll respond to the patch, as it's easier to explain
that there :)

thanks,

greg k-h
