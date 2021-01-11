Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B602F19A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbhAKP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:29:37 -0500
Received: from vern.gendns.com ([98.142.107.122]:34118 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbhAKP3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+pqtFW0/YpMF88xvAhu74Rc+HKuoTTrut+IkcV0uyPs=; b=VOShjSDHpvWNTSrlKhMG3zp/Cx
        eoqxCv2wjbk90trtoIpuEJPPgAkwezXuxt48XD1zHpGGyKLWNxbSmoY9JCgc1Tky02W7g9u1oDycr
        Ww6a1fEoGOphnqsRd/HJlGch7QuyQaZDT6e3/haF3Do9P0JcbUikaYccJ8RpVeBDffHaASuKGtVKJ
        kg8ReKBzpqQaPSKuMKIAx6g3rKg8oH8YZrXQAu5sJHamzLrKq4NhWuG6crM/L86eVuJTZ0ojt8AZe
        BwO0aB5K00fTRrz+5UxxTIcdTeesjbWQc1XIRltfQ6Q9yAlaVFaPUmlqdWka7PxV5J8LJSRhNnimo
        fOLpfEyw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59674 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kyz7n-0001cy-5A; Mon, 11 Jan 2021 10:28:55 -0500
Subject: Re: [PATCH] clocksource: davinci: move pr_fmt() before the includes
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20210111140814.3668-1-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <48e55483-7214-ef21-129f-2c1cb6ee8a3f@lechnology.com>
Date:   Mon, 11 Jan 2021 09:28:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111140814.3668-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 8:08 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We no longer need to undef pr_fmt if we define our own before including
> any headers.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Acked-by: David Lechner <david@lechnology.com>

