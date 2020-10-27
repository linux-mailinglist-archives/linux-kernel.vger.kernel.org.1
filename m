Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482AC29C040
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1817101AbgJ0RNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:13:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32819 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784684AbgJ0O7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:59:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id r186so950231pgr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fp9DOIG89yQphhVtnUaB6Uhgg6cfJ/f6CEZSpcBxAQ4=;
        b=UYbkYuZz+V4mrSNGV9sOj772Km/E4ZB7bT64Rbq2OmBMBkMYpC/7uQ71Ta7B2pS0a2
         WLcDodpDC1YTDYaBRw1CbZbZOSp5ejCOMFhRTSm3DDK3rUHnvIQVXpUAP7h/bavtyd9B
         AffszAuFp9L/C2x3u4KNpH126oHbtsOE0aVWv7t3FTD3lS67vj/zsohznzCAa6YABlL2
         3edS17Pwz9ME/qPhAlc7lKiLmqmxq9d8kGG0ADppn1UWSKP1c9YqopZqB7918qfr+ep/
         r2T39MEnfS2D3B9VQosD2qQEohJjelHEvQu8vgQdqqd5Z/sg+A0mgpmrBvaNIuXBQI0p
         YG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fp9DOIG89yQphhVtnUaB6Uhgg6cfJ/f6CEZSpcBxAQ4=;
        b=kojG8eTeSiRzm40bCPJzeL3tL/9djAZZH9FMSSn63HUZrxWJM62FkqQ4KSbY1tFq82
         CO9IAbVWjirvmvrcK+gRAo6Ewpx00U6wM87+O8erAaAZveXjruRL+QspHdsEfBWUuocr
         p6DLkUW+4eklINJ8TZDvzG4mv8wHFmso1DHjs8xrQVAbblii6Hl+/5FkGWpW01XINup9
         f9RbXKSaS8IVDjtMaMj2VRAaeRoZ5F+IrHXi5KxzRnXxvMcIQ85AI+EmKBuQFgAPgdp4
         ZyuyzwShTrK0nPFoKSvgZG/V41d/7Dqg7Wv7aXqgrAam2V8im6Pag78TzJQclbUAVKBC
         ZMrQ==
X-Gm-Message-State: AOAM530b8NvZkF9D6mrqLUI0tXmbo4ltqNXPKDW6U+9pSUMykX3wm9f6
        AhSWtJLBeL/fWWTl2V+WrquL7g==
X-Google-Smtp-Source: ABdhPJw8wLAWDU2hwTitO+GzNGBx1HZNCIcF13OgdjBXdNjI95nxmzgizBezFv/ZOrXBhMUNoGXivA==
X-Received: by 2002:a63:3202:: with SMTP id y2mr2189277pgy.97.1603810770619;
        Tue, 27 Oct 2020 07:59:30 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id u4sm2340541pjy.19.2020.10.27.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:59:30 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:59:21 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Henrik Bjoernlund via Bridge <bridge@lists.linux-foundation.org>
Cc:     Henrik Bjoernlund <henrik.bjoernlund@microchip.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <roopa@nvidia.com>,
        <nikolay@nvidia.com>, <jiri@mellanox.com>, <idosch@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH net-next v7 01/10] net: bridge: extend the
 process of special frames
Message-ID: <20201027075921.69976131@hermes.local>
In-Reply-To: <20201027100251.3241719-2-henrik.bjoernlund@microchip.com>
References: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
        <20201027100251.3241719-2-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 10:02:42 +0000
Henrik Bjoernlund via Bridge <bridge@lists.linux-foundation.org> wrote:

> +/* Return 0 if the frame was not processed otherwise 1
> + * note: already called with rcu_read_lock
> + */
> +static int br_process_frame_type(struct net_bridge_port *p,
> +				 struct sk_buff *skb)
> +{
> +	struct br_frame_type *tmp;
> +
> +	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
> +		if (unlikely(tmp->type == skb->protocol))
> +			return tmp->frame_handler(p, skb);
> +
> +	return 0;
> +}

Does the linear search of frame types have noticable impact on performance?
Hint: maybe a bitmap or something would be faster.
