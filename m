Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3D1A3A08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDISwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 14:52:44 -0400
Received: from ciao.gmane.io ([159.69.161.202]:33206 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDISwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:52:43 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jMcI6-000SJ0-MM
        for linux-kernel@vger.kernel.org; Thu, 09 Apr 2020 20:52:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
Date:   Thu, 9 Apr 2020 20:52:38 +0200
Message-ID: <59d1ef8f-4fb0-9af2-f761-b52559c8a699@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <4b7e1cf3-6fa7-60af-a1d3-2457339dbe8a@wanadoo.fr>
 <efb5a518fdc47f0120b94a7e8a95d275c0f4ad43.camel@perches.com>
 <60c732a1-aa4e-afab-d223-894a67713003@wanadoo.fr>
 <bcdfa5ae68b8cb7d9324a89aedf452f6209b570c.camel@perches.com>
 <05379b22-6755-368b-8127-8827fa020189@wanadoo.fr>
 <f212b3ad6c09e595cb91c2f7e8728d71e27f6833.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <f212b3ad6c09e595cb91c2f7e8728d71e27f6833.camel@perches.com>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/04/2020 à 19:50, Joe Perches a écrit :
> On Thu, 2020-04-09 at 19:34 +0200, Christophe JAILLET wrote:
>> Le 09/04/2020 à 17:29, Joe Perches a écrit :
> []
>>> lib/percpu-refcount.c:#define pr_fmt(fmt) "%s: " fmt "\n", __func__
>> In this file, there are some WARN_ON.
>> Are these log functions also influenced by pr_fmt?
> No.
Ok, thx.
>
>>> drivers/md/bcache/bcache.h:#define pr_fmt(fmt) "bcache: %s() " fmt "\n", __func__
>>> drivers/md/bcache/bset.c:#define pr_fmt(fmt) "bcache: %s() " fmt "\n", __func__
>>> tools/usb/usbip/libsrc/usbip_common.h:#define pr_fmt(fmt)       "%s: %s: " fmt "\n", PROGNAME
>> Tricky because all files that include it have to be checked.
>> I won't touch these ones.
> What a pity I do not know the French equivalent
> for the children's taunt of "chicken!"...

I don't know why the french one is wet, but the translation would be 
"poule mouillée".

In fact, I don't really see the need to modify many files just for some 
kind of style.
(same reason why I think that checkpatch is a better place for a test 
than submitting hundreds of patches based on coccinelle)


 From your point of view, does auditing and fixing these missing \n make 
sense?
Wouldn't it just be a lot of noise for a small benefit?


CJ


