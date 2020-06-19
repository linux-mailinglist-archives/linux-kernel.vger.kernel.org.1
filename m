Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8782C201CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391091AbgFSUvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 16:51:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbgFSUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:51:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E94AB2A0564
Subject: Re: [PATCH v2] docs: block: Create blk-mq documentation
To:     Jens Axboe <axboe@kernel.dk>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com
References: <20200605175536.19681-1-andrealmeid@collabora.com>
 <20200619134503.60ab689b@lwn.net>
 <cdab3be8-0d39-5085-34b5-7bf11cc7fb60@infradead.org>
 <a9b6447f-1b24-5f71-3661-c6ea5fe8ba6e@kernel.dk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <d99e90ae-27b8-163e-c90f-53778116ac10@collabora.com>
Date:   Fri, 19 Jun 2020 17:51:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a9b6447f-1b24-5f71-3661-c6ea5fe8ba6e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 5:49 PM, Jens Axboe wrote:
> On 6/19/20 1:47 PM, Randy Dunlap wrote:
>> On 6/19/20 12:45 PM, Jonathan Corbet wrote:
>>> On Fri,  5 Jun 2020 14:55:36 -0300
>>> André Almeida <andrealmeid@collabora.com> wrote:
>>>
>>>> Create a documentation providing a background and explanation around the
>>>> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
>>>>
>>>> The reference for writing this documentation was the source code and
>>>> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
>>>> Systems", by Axboe et al.
>>>>
>>>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>>>> ---
>>>> Changes from v1:
>>>> - Fixed typos
>>>> - Reworked blk_mq_hw_ctx
>>>
>>> Jens, what's your pleasure on this one?  Should I take it, or do you want
>>> it...?
>>
>> I wouldn't mind seeing a v3.
> 
> Agree - Jon, I'd be happy with you taking it once a v3 is posted with the
> remaining issues ironed out.
> 

Just sent a v3 some minutes ago, please check it out :)
