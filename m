Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B152AF5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKKQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:07:21 -0500
Received: from m12-16.163.com ([220.181.12.16]:55203 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKQHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=W5cWG
        wWXk3nu7LBSIHt95Byo2DTsGA15qcB3rBxTqAY=; b=hVEz6/OvnpobokAG24p5A
        DNBz45fP07BQcKuYAJULxBkzCfo+L7ZFx/C4sKVOEDwcFmc//OyZehpwJXzBACoP
        zIYHk7Q7j1ZCLTA1MN20q7D0vv8Q0Izd1L7Dl2+CNzEG6eL/On1Lsmvg62X2AccP
        C1OYAEYSofuInhxaQ0K5fU=
Received: from [192.168.0.102] (unknown [120.229.59.128])
        by smtp12 (Coremail) with SMTP id EMCowABnTGHyC6xf27IxLQ--.51829S3;
        Thu, 12 Nov 2020 00:06:14 +0800 (CST)
Subject: Re: [PATCH 2/3] lib: zlib_inflate: improves decompression performance
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
References: <20201109191601.14053-1-zengzhaoxiu@163.com>
 <20201109192508.14186-1-zengzhaoxiu@163.com>
 <CAG48ez3OyH61+hJ+Azyoae0fA6=8tnVOw3VqKebCcH=dTvh2dg@mail.gmail.com>
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
Message-ID: <2442c8fb-ff36-41ce-9349-d162639d5c3b@163.com>
Date:   Thu, 12 Nov 2020 00:06:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAG48ez3OyH61+hJ+Azyoae0fA6=8tnVOw3VqKebCcH=dTvh2dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABnTGHyC6xf27IxLQ--.51829S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4DWr13ZFy5Xr45uF4kJFb_yoW3XwcEyw
        n5WFyqka1UCwnrGF4UCr4S9r1xGF4UuFs2qw4aka9xX34fZrs8WFWDKr93tFy5Ga129F18
        Zw15ur45K39xtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0PfHUUUUUU==
X-Originating-IP: [120.229.59.128]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbByhfZgF0COtEQrwABsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/11/11 11:46, Jann Horn 写道:
> On Mon, Nov 9, 2020 at 8:27 PM <zengzhaoxiu@163.com> wrote:
>> This patch does:
>> 1. Cleanup code and reduce branches
>> 2. Use copy_from_back to copy the matched bytes from the back output buffer
> 
> What exactly is copy_from_back()? Is it like memmove()? If yes, have
> you tried using memmove() instead of the code added in patch 1/3?
> 

If use memcpy(or memmove), the code will be like this:
	while (dist < len) {
		memcpy(out, out - dist, dist);
		out += dist;
		len -= dist;
	}
	memcpy(out, out - dist, len);
or:
	const u8 * const from = out - dist;
	while (dist < len) {
		memcpy(out, from, dist);
		out += dist;
		len -= dist;
		dist *= 2;
	}
	memcpy(out, from, len);

In addition, the len is small in most cases, so the function calls are expensive.

