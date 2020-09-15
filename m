Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55B26A0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIOIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:34:43 -0400
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:57096 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:34:42 -0400
Received: from [127.0.0.1] (unknown [157.0.31.124])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id 78A455822AE;
        Tue, 15 Sep 2020 16:34:38 +0800 (CST)
Subject: Re: [PATCH] blk-mq: fix hang issue in blk_queue_enter()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, onlyfever@icloud.com,
        linux-block@vger.kernel.org
References: <11a3283f-7857-0448-7424-8840fb5f2ea7@web.de>
From:   Yang Yang <yang.yang@vivo.com>
Message-ID: <63816f52-4850-f586-ce73-3775ecc38da9@vivo.com>
Date:   Tue, 15 Sep 2020 16:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <11a3283f-7857-0448-7424-8840fb5f2ea7@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSxpMHxkZGUlLTh4eVkpNS0tKTkNDTENNT01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6Iyo5Hj8sNBYzURgNUSEN
        LEwKCxBVSlVKTUtLSk5DQ0xCS01LVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJT1lXWQgBWUFKTE9KNwY+
X-HM-Tid: 0a7490e6cb8398b6kuuu78a455822ae
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/14 21:35, Markus Elfring wrote:
> …
>> The solution is to wake up the mq_freeze_wq after runtime suspend
>> completed, make blk_pm_request_resume() reexamine the q->rpm_status flag.
> 
> * Would an imperative wording become helpful for the change description?
> 
> * How do you think about to add the tag “Fixes” to the commit message?
> 

Thank you for your suggestions.

--
Yang Yang

