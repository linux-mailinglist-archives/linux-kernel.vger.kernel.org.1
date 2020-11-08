Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85D2AADC3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 23:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgKHWLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 17:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHWLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 17:11:20 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E631C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 14:11:18 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t9so3357244edq.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQW9OKeiUXYbQry4sNj3otrATF5lu7Sb8UVFYJSJ04Y=;
        b=Ose11JQZQKZ44jTrTvreBQxy4dKe9ULvwGFigLaVW6YJKWfeP/lc5w3J+xTeuos7Jg
         g3dnOtMpDmfNvj+aZ35fMCUZInJpoSwXhAzWjPM7ghKcwUGC3ONa/OLdVKUlh/NC7j9i
         tLcWnUpliAt8lfDjzdQwIAGiuxrnwbeNOKnzVduabNJ3HrKq8Zf3GqiMp/sQvwteb0M+
         4T1AFjad3THIPfh2TCidVSt+5baTMIUZxEhQ91k26MZvvfYV11QowKumDCS99rqOZA3O
         p157YXNhqyHGj8546duSm/OY74Ekq3t+MNLb6PC0P0N4KbP1rt9E0NfiQNbkeT81rGQS
         +sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQW9OKeiUXYbQry4sNj3otrATF5lu7Sb8UVFYJSJ04Y=;
        b=ofLGYJmDYnYla7zu712ipzsg4/f+CkYyLmWu6/bcwRDHqvCIYfFpjhQxymESuaqKtD
         6PGQ+ktaqtfknDDIwQKp/cHObm+XLD2XsWeFprPB74hwQN/qqPE6ycJGO8ArRgpro2e2
         EPVEMgEnEeOitsOwdaOLG2auD/6mEZ0Uz2KV19CFb2IzFjiL5siSfIChudxgK650YYy/
         JvCTA8inuSK8uIxChQQbd/3OfeXPwRt5zkTKmh8ALRksMqpkIom82Hsif+GPXAfusVzV
         s15jazF6U699r4UPDNLS5GzSDNRIoxj43Y+FH2kicCWF87tri+KkezKgxAJCg7b4sp7k
         CmXg==
X-Gm-Message-State: AOAM532QxgLY2xFxuMQZhBD2qi+Sgbtzd2DahvNOwDqLf4on8+Uy4hfu
        S7vjmuy/J44rbZ7rAhtDcTvf/I1ncVPpXy+6TO2gQra5QrE=
X-Google-Smtp-Source: ABdhPJxn/TUQyzh6+DX45a3IbFyU0IhAwdKmAtLx6F6Atgx8uZkRWU9ry1zkd7IKk/r7RxoEvUq6DLrR41bkR8B6XTw=
X-Received: by 2002:a05:6402:3d9:: with SMTP id t25mr12720413edw.338.1604873477430;
 Sun, 08 Nov 2020 14:11:17 -0800 (PST)
MIME-Version: 1.0
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com> <1604642930-29019-2-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1604642930-29019-2-git-send-email-chunfeng.yun@mediatek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Nov 2020 23:11:06 +0100
Message-ID: <CAFBinCCdYB0YhbT-sDe3-g+CT_Lj+7jRY1dXcwDHucVBTaL7CA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] phy: amlogic: convert to devm_platform_ioremap_resource
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 7:09 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use devm_platform_ioremap_resource to simplify code
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
