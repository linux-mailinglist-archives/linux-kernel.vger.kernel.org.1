Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E781A16FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDGUuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:50:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34140 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:50:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so1700742plm.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KnDK4lPfD3ThErmqjMOkJqIG1D+dLUhlEHhC7zHGyQ=;
        b=kMRk+d3kGoGcM14Fj8KK6z5Yvpj78HolILDt022nsA80s67Q95IBM+hKdlhH5N2RnO
         3/mgjP1ddXUULum6oNJhSEnrIeKVodpQSFDuAZqRhtagyUSceqFxyFLGfXYu5tqTQbh9
         HHanuj64WLpepEnv+UBQbLWE317V4JxGa1/DxCnMYQ75WmEymU8yYpuQ9elGGMpTDaFQ
         MprXCN7RI5uVTYSTxBL659EZZWhXHh6rOJm5qLunYqEBNkovi++89DtaQAR/CCLjAOdk
         jO4BLYH5uXWuCmjm5s40CHFXjoCwsKKDfEbOhaIJROGqz7uC63sa0/msjf7CDQT77wvr
         tx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KnDK4lPfD3ThErmqjMOkJqIG1D+dLUhlEHhC7zHGyQ=;
        b=Fe7pCURfv9JQHZCIyT6hkcsBSuLq9IZ/2wXyVYgN4WZ/BOiZTnGbYo13eqq8teAwZI
         cta1kATv0MB7NdfhoCLpMMJiu7fKHw+7O8g7LD64Az6DW9bzkqetlXs0dDazF7wwMLMQ
         5AMnwAB3yxb3fQzzc0UymzXwwxUOE5w7mMTrcf+bXSXLZ//9aSqzaDfhDXPu+k5jLTCJ
         B15XA1ySsBubbPziHZ+1duYfxRS7Qw0sEgn9HDFbBjUrTi9e4VWWL1gc77lCo/BMKq4L
         qXrgHU0fHiYzhSjNTpiJHx29WYa/gU/ZZb3wRLgg9627hoD4MTxRPKnT9eExz/tXt1yl
         sfiw==
X-Gm-Message-State: AGi0PuZMtUu8CYioLoGxcXFWm/MXHCBzYnUaDp2PMQXZq1ZduAnSPSwj
        JMcVVL4kShGYv3SLK2EvcDIOWaMP5docLA==
X-Google-Smtp-Source: APiQypIxqfTmYOscCTssroZulr1ZWx6qppCwC/i48VMqcar+nE80Hxbwwzzdacvkw01iJ8lW+FtHrg==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr1232457pja.174.1586292600830;
        Tue, 07 Apr 2020 13:50:00 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id b11sm862891pgj.92.2020.04.07.13.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:50:00 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci-imx: remove redundant assignment to ret
To:     Colin King <colin.king@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200405115120.366864-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac93c383-fdc3-a818-9e3b-faed462c31e5@kernel.dk>
Date:   Tue, 7 Apr 2020 13:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200405115120.366864-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/20 4:51 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

