Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE52AADC2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 23:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKHWKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 17:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHWKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 17:10:39 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE57C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 14:10:39 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id e18so6735920edy.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 14:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeizlBIhrONwi1zUfvnaytr0f4firOnFbhs2cQ5A+dA=;
        b=QAFGlZFnBnIxjenxIPbtz10/wcCiOaLzkcoXHArQNkl3qzMsMzT5If6rPLz2uVYlcT
         5XGTPN7XXlpvRiZq4nLxzFt2xoPXUgCsfBe4b3268VPFzWLtQ1ZjaNleiE86/UUrx+2K
         /XXHREWzdkdme2RhFLrlLBFTG1aCgXWZCtcac8NKKKCWqKVhtIJE/xbaTV2jgxt/YUDT
         84F8YE0t6+HaMCIOCCmx3J5hqzDiHQXq2u3b9tvE6gilMP7z4Qxxe6xVl+gkLbQH1tX0
         iOM+MJbJLOLuavrqUmkwpnUGnO5jPe0Jaf3ZC/xyrO5WuT1mA674yzapU6nOX02pwpHx
         rYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeizlBIhrONwi1zUfvnaytr0f4firOnFbhs2cQ5A+dA=;
        b=OYYicuDyjA8cjauBZRy44Qv1unx8UEM8UV8M2NLM6mBDqyD7ye1LmZVX5GfNRAKGX5
         jwTnb5zqg0TICvtJmV35YrqAFPqVaJ23/1Zte0TQxsEojTx9qjAol7WejagoG0LvKQui
         a7idBR2YiKsvsiO9VXitVojRrIEmX8xPmsi3K2dqfuvp0FoCXxBETsLfz0z56SSqUFSj
         W0kK6Znz7EFtWo9M7xnBjHWd8GvQXXSe4Fz+m7bsrBeP5pRgp2yBt3rLwse0uWO7vxlT
         prBhX+T5ENTCT9uLNkvC0cH2Rz8zbW3OCY6T6nG264rUOueaKsrCnKDOnddwSm1ON5eH
         pehw==
X-Gm-Message-State: AOAM5309wBoR+XMRAn67VqrgMR3v7vzQlCfJUi3HuFmpgcwC2KdTs2uA
        963I36g37n3naZjKVHttXx9A6aateVYRD1xXZqo=
X-Google-Smtp-Source: ABdhPJzQpwb1XQIG1Sp+x3CRY5rDrdUQkAY/lj4tZHGqSnAzfSmvUoQihhwA7DERq2+RuM1AalGED2ndhrQbRpgwujc=
X-Received: by 2002:aa7:df81:: with SMTP id b1mr12210809edy.365.1604873437961;
 Sun, 08 Nov 2020 14:10:37 -0800 (PST)
MIME-Version: 1.0
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com> <1604642930-29019-6-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1604642930-29019-6-git-send-email-chunfeng.yun@mediatek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Nov 2020 23:10:26 +0100
Message-ID: <CAFBinCAeTRCaho7Pc56YaX2wbEOrbW+Rx9GxMA1GsJr1Yqhp4A@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] phy: lantiq: convert to devm_platform_ioremap_resource
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 7:09 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use devm_platform_ioremap_resource to simplify code
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
