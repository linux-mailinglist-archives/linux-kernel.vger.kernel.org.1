Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C725F042
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIFToG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 15:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIFToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:44:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D4C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 12:44:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so420107pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oS02zA1VYEt/yvDSE3Q9ugNSM3dwx/SDZF7dgwbaQcA=;
        b=Y3dhlZFCms9a90fYwZi3NGCXrYtrZmaY1MZVQbT/xzrX/N2lmMQN9eGnU/10pylHyp
         wwUutpWgcmYz3Ebvbys4guE3BWkaZqiiDW5cOIQJs2rsRYI0kk+zSs7NZ983QzxYXF3P
         Rn0uML2D2ab+mgySiiYYKd+0LGeklPrwKX2HWijYkzMrXo8TPkglNKojBlLueXOMYjku
         VuBm3uTzSPbo/JEKcga/c9Qq5Zjg69AXRYDmTtIJfUsfWGDlwtksrnqMd1Y5PYE6Rads
         PhT6jGCHxt/x44QXTqjblzClLFWESuK68HWo6xn9FsD3M8GFAM5fR88e0dlhBLzVycu+
         8vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oS02zA1VYEt/yvDSE3Q9ugNSM3dwx/SDZF7dgwbaQcA=;
        b=OAZIdMHitg06IA9zJVwtgogZXBF7hFmrvmxL9Cv1ucOLbLAEv3xMrfoPGu73Dq3WdP
         yiyrcLJPsf0fGQHU9xF+UJuQIyIEfn5XM+A5FnavMmsOXDWzOLL/2oMgZtBK4Ns/kET6
         wlkvhowCPUpV8QhP/dbL46lFTCRBs1m33jcTfx/mlp+GfxfHU9eNjQ3I+CsPY3Xy93DJ
         lEia7Jv/cyX38k3RQ8L8lpXvviSKhomHIR0Oj/sG+A12L58cYhEci4c1Y2+KOlcN3Tb+
         38DaA7NUCdrhtr4N7lvs1xMBsQjTK8pC/t1a2edwA4PuIcSuTJuQyxQ2UeKfZCg4xM+7
         4lCg==
X-Gm-Message-State: AOAM531mHb4RyecMLEswXgIRCWP1an47dneYKg+mpIjdLAbAG1ti3hQw
        VQA2qFEWzwFyCBNUFTlzt79Cm6aaf+4=
X-Google-Smtp-Source: ABdhPJzGl+VszRq1nnliar/2p6FSDFWuVvbmZSwp9PaSeN6x2IMFAa/uY//FRWBDEhzh7ILiBa9yBg==
X-Received: by 2002:a63:e504:: with SMTP id r4mr4003285pgh.431.1599421438634;
        Sun, 06 Sep 2020 12:43:58 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w203sm12586623pfc.97.2020.09.06.12.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 12:43:57 -0700 (PDT)
Subject: Re: [PATCH 0/4] soc: bcm: brcmstb: BIUCTRL updates
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200904205055.3309379-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <54f4b19d-8feb-c780-6b5d-2b6ab6c97d30@gmail.com>
Date:   Sun, 6 Sep 2020 12:43:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200904205055.3309379-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2020 1:50 PM, Florian Fainelli wrote:
> This patch series adds support for two new STB chips: 72164 and 72165
> and allows them to be tuned the same way other Brahma-B53 chips are.
> 
> The last two changes are some minor configuration changes to the
> read-ahead cache logic to improve performance for Cortex-A72 based
> systems.

Series applied to drivers/next, there was an incorrectly updated comment 
in the last patch that was removed.
-- 
Florian
