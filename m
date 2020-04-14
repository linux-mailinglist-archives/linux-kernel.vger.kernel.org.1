Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063761A7780
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437704AbgDNJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 05:40:51 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8075 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgDNJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:40:50 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85e958509904-50b11; Tue, 14 Apr 2020 17:40:25 +0800 (CST)
X-RM-TRANSID: 2ee85e958509904-50b11
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e958509cef-73c4e;
        Tue, 14 Apr 2020 17:40:25 +0800 (CST)
X-RM-TRANSID: 2ee65e958509cef-73c4e
Subject: Re: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
 <20200413113225.GB3587@minyard.net>
 <47c06465-9ae5-42c2-ca00-5c666521bbde@cmss.chinamobile.com>
 <20200413142348.GD3587@minyard.net>
 <3894dab2-0660-999c-6f4c-4b5b9ff57773@cmss.chinamobile.com>
 <20200413215941.GF3587@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <73acd099-f9b3-8eeb-f580-297de2321953@cmss.chinamobile.com>
Date:   Tue, 14 Apr 2020 17:42:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413215941.GF3587@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey:

On 2020/4/14 5:59, Corey Minyard wrote:
> That is all correct as it is.  If there is an irq specified and it can't
> be requested, that is a problem.  If there is no irq specified, that is
> fine, just info is good.

Okay, I know what you mean, and I will submit the corresponding patch 
tonight according to the questions I raised.

Thanks,

Tang Bin



