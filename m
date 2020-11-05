Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102402A8382
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKEQ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:27:10 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CDFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:27:10 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id c5so1491941qtw.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=roNw57hB7NU/TnfvOJxxpvuID9SfMYdoxWpjVnE/nWo=;
        b=L8jp5xjn2UMt/EXs20OGFSXy/pk+JVNpuRSV/GW6yHBDqrTrDq5U5bCL+iY5fcOAbH
         7OA3swxl6etwaNjnIv0YTY3q/XlODbPDBGeGmat4sLYvepi97cs+7+gxtXkc7OUtswCy
         D+LaCWDW8uJruWkkcgkxgBjBvrxz+mj6TPlNPBK+oAuo2TWuu09fOuvc25UGVbxwEQZ+
         MbFzVk4bp5Kb9L2cRr/kWQKhkT5jrz388q44MuGIGjEHHORednCfNLTTB7lxHaTcio2p
         Ap9DtfvGNOXVsqmBnuCBCh4WBXkwYMxZFj6Z05xZuhwuvPJ3Le+PIhNlcCQYnoFhYC7+
         lf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=roNw57hB7NU/TnfvOJxxpvuID9SfMYdoxWpjVnE/nWo=;
        b=Ens+lixa/0U5/YeGx5SGpbQzyhwPuEPPOou5hE659ZjXa53IOrzL5+I/0eByItspPK
         C+BbrZardTZvC2wDZDYhSHSGfOrwsYXWTIx6/DygodW2/697VXj7XMD0RjclDky4q0zS
         GXd/L6AMBGb0rUarlHFutW7zNImbMRYQrApfwXOJAGeugeIzYkPWrq1ZV/stjdMLqxIs
         Plmz4QjFF463CO/e3hSnvC/sbQ1SkiCX4MKY+ckqhl2TroW7LfTqTMfehN53Amv96Cut
         yxGB5stinlQx5NsAufEWtqk377icBjfkPnXx/na7n77bBOQGhL9lUw2tbEeOYd3s6qqU
         /isg==
X-Gm-Message-State: AOAM5317pRR23eL1C6B5DemLHCzfP+dustTJDvrp3i0LMl8dOEnh1DJd
        QvDdPrWxFH7ZlEH8PRTmP7yvNg==
X-Google-Smtp-Source: ABdhPJynGVyw87IjoO2KAGvV/FU8kPGUmMOdiP46PBtyvjQ3HDxf7yNU6wnq35wzUNxv5nukTsCaxg==
X-Received: by 2002:ac8:65c6:: with SMTP id t6mr2648352qto.339.1604593629797;
        Thu, 05 Nov 2020 08:27:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc05])
        by smtp.gmail.com with ESMTPSA id 82sm1308994qkg.103.2020.11.05.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:27:09 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:25:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        mhocko@suse.com, laoar.shao@gmail.com, chris@chrisdown.name,
        tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: fix missing wakeup polling thread
Message-ID: <20201105162523.GH744831@cmpxchg.org>
References: <20201105161936.98312-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105161936.98312-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:19:36AM +0800, Muchun Song wrote:
> When wen poll the swap.events, we can miss being waked up when the swap
> event occurs. Because we didn't notify.
> 
> Fixes: f3a53a3a1e5b ("mm, memcontrol: implement memory.swap.events")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Cool, thanks!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
