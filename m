Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80652D704E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395553AbgLKGjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391569AbgLKGjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:39:05 -0500
Date:   Fri, 11 Dec 2020 07:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607668705;
        bh=Fn9KCxNyUNa1/7Xo5a7208WUqOyLaJdJHmuGofIPEgY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeXhrUoDZuAohKL0X3h/V42qFSN4Bu7zbjdQWbBUKDce8XwB7FUwiAl//jyBY/pXi
         oDjtx8GoSKrpfiupNRu9JqCrg3bTHWU6TRz/0X7JkA8U130/8hq0e0s+D5CAnXmfOF
         aBA1qxu1bwDMzNk9lX9arguEixStaPz8hre9etD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 5/5] USB: typec: tcpci: Add Bleed discharge to
 POWER_CONTROL definition
Message-ID: <X9MT3O+X8jlv8tU0@kroah.com>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-6-gregkh@linuxfoundation.org>
 <20201210174548.GF107395@roeck-us.net>
 <CAPTae5JBj1PgZw7=00ZPuT8OZP7=SNSAcPBtaiQ_LyxZm7UhNw@mail.gmail.com>
 <CAPTae5J2ex_0h==a23PvKA2Xfnze0K6w9v8dpiSF_DEpRf8BSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5J2ex_0h==a23PvKA2Xfnze0K6w9v8dpiSF_DEpRf8BSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 08:47:04PM -0800, Badhri Jagan Sridharan wrote:
> Hi Greg,
> 
> I have a patch ready to enable BLEED_DISCHARGE in tcpci code.
> I will send that in once you merge this patch to usb-next.

Feel free to send that now, no need to wait :)

thanks,

greg k-h
