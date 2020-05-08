Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4358B1CB14F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEHODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:03:52 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:11669 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:03:52 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5eb566ad567-5aa66; Fri, 08 May 2020 22:03:29 +0800 (CST)
X-RM-TRANSID: 2eeb5eb566ad567-5aa66
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.43.52] (unknown[223.104.148.118])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65eb566b064f-40e24;
        Fri, 08 May 2020 22:03:29 +0800 (CST)
X-RM-TRANSID: 2ee65eb566b064f-40e24
Subject: Re: [PATCH] USB: EHCI: ehci-mv: Fix unused assignment in
 mv_ehci_probe()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.2005080948560.19653-100000@netrider.rowland.org>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <5bc2ecec-eaff-7ec8-573d-959f9de395ae@cmss.chinamobile.com>
Date:   Fri, 8 May 2020 22:04:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.2005080948560.19653-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/8 21:49, Alan Stern wrote:
> On Fri, 8 May 2020, Tang Bin wrote:
>
>> Delete unused initialized value, because 'retval' will be assigined
>> by the function mv_ehci_enable().
> This should also mention the extra blank line that the patch removes.

Sorry, my mistake, I'll send v2 for you.

Thanks,

Tang Bin

>


