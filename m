Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DE299202
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785197AbgJZQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:12:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55676 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785090AbgJZQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:11:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id a72so12245094wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MrGekxdAPW7pCql7h2Tv9omsiLJVrXPqKjbDYUjsVnA=;
        b=aelHvFZ7VVoaw66b/eTLcw4NHujLV695zzPkcCEpslJ4CI5ITS6vQRjIAN4sm5h9LB
         d10q/bjwym5UJov3m8CGeWzzCl8f4Didlm5LECv+ucmsz85lSdD3UC5JJVUWBphTWCYe
         vI2SbXAmqTzZF4t4nxS5uWOMlhpZIpP1EZScernN5WsxN4J4MLnzITdjcHPKyGmhopq0
         XjGEpfU6kegq+H8XTOhN9UVU1DUfoa1DWrpZ7GTbPMp8iD6s8OSLDoTqtrkKxuy6WCiA
         woL6ZF4W8K7yV//EyLospwQj9LwbTSynxgbXd6MjAOst7ImQwE8e4C+NjdfY7buKJBUm
         991Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MrGekxdAPW7pCql7h2Tv9omsiLJVrXPqKjbDYUjsVnA=;
        b=tmfqXJpM6dMuquw0bU0MCt2xpWiZVfGL7IRYm/QzmU4at7XbOBQ9o65DSEmXvMP32o
         1CSGb2Lrbn9lF+j0TAr5JcCmmhKpNbd8s/2t7qAsYtG5TjYqQkK7MUgk3Wu+3VjVdxac
         cYdT0v11F0OKpf7ExxZrsXwOVP7R+8Xm7ie1JgrrDcEDNDPw95ce6hy5/wyr7D1TitGi
         CVjOE/LEwJ1I76qzoEK1vsfbgMgaoZ7uo2J4mFNmo2/gjxTlizGBKIgkKjViJFlQqncQ
         Wnt9reap9VU5iw+ah9cQVFOygf3aRlC2lhgqH2ERaQM2p2G+ZlVTNZBFM4V3G6cUDpOY
         WmQA==
X-Gm-Message-State: AOAM530r9oi9wKnxmQUj6efHZr42RHE5JYBjbtwUpCkX8Vjx5TIgb6vh
        v6vJskCgjhTXnnJy/JF269ghdKO3k6d9PQfj
X-Google-Smtp-Source: ABdhPJzXeKf52x+EglQ1SghEou/lfwa539rkLDDRWOkVklRdCre8gRDAcrgh2xpkYdkN5qhbfxywHQ==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr12411658wmf.104.1603728706221;
        Mon, 26 Oct 2020 09:11:46 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r128sm22825689wma.20.2020.10.26.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:11:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/3] clk: add api to get clk consumer from clk_hw
In-Reply-To: <20201021162147.563655-1-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com>
Date:   Mon, 26 Oct 2020 09:11:42 -0700
Message-ID: <7hk0vdhsqp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset a call in CCF to get "struct clk*" from "struct clk_hw*"
>
> Changes since v1: [0]
> * Add a con_id string to help keep track of the consumer
> * Add devm variant:
>  - Following our discussion on V1, I choose to have the dev as
>    argument as most devm function do. However, as Stephen pointed out
>    we don't expect this to differ from the one linked to clk_hw. In
>    this case a warning is thrown.
> * Add a first usage of this in the amlogic clock driver.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested this on a couple g12a based platforms.  This series also allows
me to build the g12 clock drivers as modules.

Kevin
