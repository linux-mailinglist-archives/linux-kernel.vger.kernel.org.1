Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5B267A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgILMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgILMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:19:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314DC061573;
        Sat, 12 Sep 2020 05:19:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so16917287ejr.13;
        Sat, 12 Sep 2020 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VUoJN9xUq0dsow+Xj77VGEneD+l13rpg7IM0TaqQT6g=;
        b=gOJY7liRCq1NUD32YfPAGCcA1HhiWU9xk5RTNXYOdjJDUXFdhC0mEKpMbvkhRS3RIk
         SoKKBQ3RPxITsu1c3npUvULewN/LOYdIppQV1VHl3XbeARB0bs4JtP9Jn6+A5JyqXLsi
         zMchy1aQT7Hr9BaUlWhrmc2NVw+cgETUlXjahId7za+YkggT1/8NIsJR0Wji1v2DYPk0
         iIjanzO2AnF4QHdBcaz0rH/2BQF6b3/TrJsbk/kJb8I6NJ7+VunE7zOnuIcwWKR/0Qwr
         a11d6AJfF6h0FWL30Mpny2YRxcNxZHb9uo4FQmaCMmKW7qotuUaySLA/dchh1yG00vCp
         RQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VUoJN9xUq0dsow+Xj77VGEneD+l13rpg7IM0TaqQT6g=;
        b=pOhYFfCcWpIC4gdeROvKopf1gpmnrqTMnzpbHh4P1j0cMNlW2bKwbMbrV8/6HBlHBK
         DpaMaT/yOvow1JSONNshi/dii/06htHeZe9lauTmIGgpIX1aPTuScMqxTwJnTeKQ1uMG
         pKkve4aNKiWX9YC4pfZCnCqkfvJrnxocL0wC7z0LT/W0LBM1Ej9Sbwui4f38XIfLONyn
         u3rxAPAXVWEOhCIkdiiFKluaJfqrMLuq4iKQ4OEBpH7nt+/NrNIESCJH+mSgYhYFcxH0
         EA1OGgbjMAhElZdYUTr2QsLJaExz28iS0cXK0xRf07l6gSQPALHNnwEcWlqDIaT+vLAx
         7nIw==
X-Gm-Message-State: AOAM532k2SIaXoL7UZsGyRRxpufydQ1b6vab4QvCzNzdRDxgW2Z6rPI3
        FDZY2szDE0x7GYcNcl1V5tQ=
X-Google-Smtp-Source: ABdhPJzs4KaGayyivoTuGu0z94Ksn0sVjTPYTEp7wYSjTDY1qgPzfCKA/BHwVrBNccnIwQXEQ0ltMw==
X-Received: by 2002:a17:906:f90c:: with SMTP id lc12mr5762295ejb.104.1599913149197;
        Sat, 12 Sep 2020 05:19:09 -0700 (PDT)
Received: from felia ([2001:16b8:2dd9:a000:782a:45ff:c1e1:cfe9])
        by smtp.gmail.com with ESMTPSA id y25sm4534063edv.15.2020.09.12.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 05:19:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sat, 12 Sep 2020 14:19:02 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-usb list remarks consistent
In-Reply-To: <20200912121346.2796-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2009121416500.3770@felia>
References: <20200912121346.2796-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Sep 2020, Lukas Bulwahn wrote:

> This patch submission will also show me if linux-usb is moderated or not.
> I have not subscribed to linux-usb and if it shows up quickly in the
> archive, the list is probably not moderated, and hence, validating the
> patch.
> 

The patch showed up in the archives within seconds:

https://lore.kernel.org/linux-usb/20200912121346.2796-1-lukas.bulwahn@gmail.com/

So, the linux-usb list is most likely not moderated. Patch validated.

Lukas
