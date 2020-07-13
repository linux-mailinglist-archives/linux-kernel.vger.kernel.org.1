Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097E21D3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 12:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgGMKwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 06:52:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42935 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728883AbgGMKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:52:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2ZrLm8_1594637531;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2ZrLm8_1594637531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 18:52:12 +0800
Subject: Re: [PATCH] doc/zh_CN: add Chinese translation prefer section
To:     corbet@lwn.net
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200713093123.45269-1-alex.shi@linux.alibaba.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3d618299-9b45-7aca-afbd-8513fba021b4@linux.alibaba.com>
Date:   Mon, 13 Jul 2020 18:51:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200713093123.45269-1-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/13 下午5:31, Alex Shi 写道:
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index c503188880d9..b5b2be8eec22 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -36,7 +36,7 @@ needs_sphinx = '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> +extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',

Sorry, this part was included mistaken. I will remove it in next version.
Thanks!
