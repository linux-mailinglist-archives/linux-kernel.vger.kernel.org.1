Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73762A78B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgKEIQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKEIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:15:55 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCCFC0613CF;
        Thu,  5 Nov 2020 00:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5ET2Th0DyRXW62bKDsEdxAhHY06okhpZXJ0yl0uHDqo=; b=FxWOGn5oEkgTjRrq4kihtZ4t7D
        gVqnMswbqzI0Ypo9pHJQWmqjgoMfcEcx5p9TqSrRPm7nzpeQTzTLPkpaoogG5WrtnMGFfKD6ypBgt
        pu3Q9uQbB5OOgX2EOhMynlFNXxtxNsRnTAEp63LCarsf+dd0CbgRg04EkvlUPj2TjM20=;
Received: from p200300ccff0ddc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kaaQu-0005PD-DV; Thu, 05 Nov 2020 09:15:48 +0100
Date:   Thu, 5 Nov 2020 09:15:47 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Brad Campbell <brad@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
Message-ID: <20201105091547.3335aed6@aktux>
In-Reply-To: <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
References: <20200930105442.3f642f6c@aktux>
        <20200930164446.GB219887@roeck-us.net>
        <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
        <20201002002251.28462e64@aktux>
        <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
        <20201006090226.4275c824@kemnade.info>
        <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
        <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
        <20201104142057.62493c12@aktux>
        <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
        <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
        <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
        <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
        <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
        <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
        <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 08:56:04 +0100
Henrik Rydberg <rydberg@bitmath.org> wrote:

> Hi Brad,
> 
> Great to see this effort, it is certainly an area which could be 
> improved. After having seen several generations of Macbooks while 
> modifying much of that code, it became clear that the SMC communication 
> got refreshed a few times over the years. Every tiny change had to be 
> tested on all machines, or kept separate for a particular generation, or 
> something would break.
> 
> I have not followed the back story here, but I imagine the need has 
> arisen because of a new refresh, and so this patch only needs to 
> strictly apply to a new generation. I would therefore advice that you 
> write the patch in that way, reducing the actual change to zero for 
> earlier generations. It also makes it easier to test the effect of the 
> new approach on older systems. I should be able to help testing on a 
> 2008 and 2011 model once we get to that stage.
> 
Well, the issue has arisen because of a change in kernel to make clang
happy. So it is not a new Apple device causing trouble.

Regards,
Andreas
