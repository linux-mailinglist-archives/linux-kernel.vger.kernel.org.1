Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491891A63CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgDMHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:42:39 -0400
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF34CC008651
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:42:28 -0700 (PDT)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e9417d64cf-33710; Mon, 13 Apr 2020 15:42:14 +0800 (CST)
X-RM-TRANSID: 2eea5e9417d64cf-33710
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e9417d50e3-b038b;
        Mon, 13 Apr 2020 15:42:14 +0800 (CST)
X-RM-TRANSID: 2ee65e9417d50e3-b038b
Subject: Re: [PATCH] binderfs: Fix binderfs.c selftest compilation warning
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arve@android.com, maco@android.com, tkjos@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200411145151.5576-1-tangbin@cmss.chinamobile.com>
 <20200412074629.GB2707594@kroah.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <54f2439e-e74f-fc45-96c4-c7744fff6162@cmss.chinamobile.com>
Date:   Mon, 13 Apr 2020 15:44:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200412074629.GB2707594@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg：

On 2020/4/12 15:46, Greg KH wrote:
> On Sat, Apr 11, 2020 at 10:51:51PM +0800, Tang Bin wrote:
>> Fix missing braces compilation warning in the ARM
>> compiler environment:
>>      drivers/android/binderfs.c: In function 'binderfs_fill_super':
>>      drivers/android/binderfs.c:650:9: warning: missing braces around initializer [-Wmissing-braces]
>>        struct binderfs_device device_info = { 0 };
>>      drivers/android/binderfs.c:650:9: warning: (near initialization for ‘device_info.name’) [-Wmissing-braces]
> What compiler and version is giving this warning?  It's odd we have not
> seen this yet...
My environment:

   PC : Ubuntu 16.04

   Hardware : I.MX6ULL

   Tool Chain : arm-linux-gnueabihf-gcc (Linaro GCC 4.9-2017.01) 4.9.4



Thank you for your patience.

Tang Bin




