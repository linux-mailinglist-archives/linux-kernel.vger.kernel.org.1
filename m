Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E085F2D9BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438915AbgLNQEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:04:16 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42195 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgLNQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:04:15 -0500
Received: by mail-ed1-f44.google.com with SMTP id v22so17663504edt.9;
        Mon, 14 Dec 2020 08:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1R4GDxWiInTOSiMoQjKp8/x2VzpM54rp3XHLP51YQwI=;
        b=P2B2HFCf/Pr/voP7CqYiDGHeitRT+zhl9e7MoR9NxrDScm7wj7os+v3yNCQbLNK1d2
         qu64k6l41tZrJGj5fMxwuKFHnseHFPNkB1DFHKglgV+m/S5o37F61hXjzygYsjy+cPnt
         UEDXodoHUgFAE1tq5b2gD18x9iJ+VYA8o/6LCuTcyACMv8N57FHXFQCZ+8AGLKUOWLbg
         YTfGU4FfW4qdYCUymlJajuXg2fZYW5u4DAGSSKwOv697Eu2YDrJkVd0qRGj4KxisCA5v
         WWE0CFVOAGwOYN4FBOXXrOhNmWRcrjAzYTCJgUyScQKfT6JvTet5umXFn9+mklDrtdNA
         XX5w==
X-Gm-Message-State: AOAM532Oodlab53wxX7HY+kDCakYJVW3VHZtfr/DZODGI1l7fDL79xM7
        WQbowBUmNS5smI4QcSymxu8=
X-Google-Smtp-Source: ABdhPJzHHpwR8U0nzeJSHKtRQNJXEPTkA0gNm/3ZDzH5g+76QEADqu0ZfPZUY/ikA7431T6AhNY6JA==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr25315986edk.377.1607961813452;
        Mon, 14 Dec 2020 08:03:33 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f18sm15784210edt.60.2020.12.14.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:03:30 -0800 (PST)
Date:   Mon, 14 Dec 2020 17:03:26 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fbdev: s3c2410fb: convert comma to semicolon
Message-ID: <20201214160326.GE2493@kozik-lap>
References: <20201214133317.3622-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201214133317.3622-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 09:33:17PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/video/fbdev/s3c2410fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
