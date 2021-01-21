Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CED2FE9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbhAUML7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbhAUMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:04:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789CCC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:03:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so1303386wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vuLJ7p5ilfIWpz7PW8WlQI72IXUVIdtMvIHeFbz24w4=;
        b=zEXssm+figj+fIPe8hEn2JG7m79MYv83+6paGQx2LUIHT8guPQSBUNuQc3+xKbL2Ss
         rxTRjElqWHDgex07G7TvnzUskB+a0tz0cvG3GnmYQjjBS7FeygrjR/H3bpLh+oulYD4J
         kZUxB0hvpmq2D3vmV17wjSBIe6VyWYlr0EA2FjkdYwouyNLoe1GH++aBdFX0Xnq/MzPs
         cbXQP5iAbUZD6v/jDWkciFxlPqK9KsQnRTncv8vAATMrsG/SU1YkyQ1TiQeUXx2PwL+M
         HaYevWr3WWDIlUBjQOC7TEanYxGtS+70GSBdYOR0ZcxLyQjIaLwIH33A+XvOAjfohU/l
         a5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuLJ7p5ilfIWpz7PW8WlQI72IXUVIdtMvIHeFbz24w4=;
        b=MQiNGqbIocQm93c3jDIikIMn8e6DXbszvPy1ZhsaOoyCMiMSLLeD+z+zRqBk2LykHm
         UamJ3HCoJ7IZd43mi8H+1xVU4PuNM6U+Luka4oMMj+PMw4d0vqZ11wTLMd6PDYxcq05L
         /TxSISWcn2RibIDa9KlSSOzBs3efFVabdr1Dl9T6PD6Cztu2uX89AxEwvm6i509q/+A6
         2eAAfk0aItae+RXSs7z07AEB75+bKbngyhCC+fuBUqUhWZZNybi0TeZDOKPpH6FJiF0k
         T3mpTglVRs++F/fL0/2nMXVUpILrjOmG3G6eLrB23LEYr5InE7zmA0zfhyAiwNTiziZe
         MLvw==
X-Gm-Message-State: AOAM531rNiY+X1vEeK1xS3/dHO+YHMuZKFc1Oc149YTBbNCWhZBbV1GV
        3Y7LmztdQaho3qsXrfFnsiyDTL6I/rchfg==
X-Google-Smtp-Source: ABdhPJyxqriq44Jy62yZDNpVCqIweGCa+fd8anF6p7WTiBOksuCirEJkV8YRgzzex/wi6ldb9flfsA==
X-Received: by 2002:a1c:2003:: with SMTP id g3mr5969108wmg.90.1611230635237;
        Thu, 21 Jan 2021 04:03:55 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id x81sm3288060wmg.40.2021.01.21.04.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 04:03:54 -0800 (PST)
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
Date:   Thu, 21 Jan 2021 12:03:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/2021 19:09, Pierre-Louis Bossart wrote:
> 
>> currently we have
>> /sys/kernel/debug/soundwire/master-*
>>
>> Are you suggesting that we have something like this:
>>
>> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
> 
> Yes this is what I was thinking about.

Vinod/Pierre,

One Question here,

Why is link_id part of "struct sdw_bus", should it not be part of 
"struct sdw_master_device " ?

Given that "There is one Link per each Master"

--srini



