Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555302D6C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgLJXtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgLJXtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:49:24 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:48:43 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id r4so3651119pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=AG5j6KdzOrOIZlpP/G9Y3cE+K8n2ovOPbsXUJ+7wxSo=;
        b=FayvgMRlRj18DT5FRCj2xQ+hkc14+FsGexb2ndZ1Rek0uG3kjNwv4fcZqzZVSgroTD
         5hz6WjzLi0eqDuoGrSg0SDv7+IF3relQUsha969dYZ60zo8DvVlObmt3hZ5+xqXGUgb9
         fUjxPVSO1iXVRso/n0LxRCwCmeadiV3AWBhyeHigIiZPDIg6ePSrNQ4y5913weR3hx2M
         OjQV2VJ/zg0guoP9VrOFyRsH3RA+XUFFHbbnHc7kobQ+vKik50uKRpWccpzaT2Cx+2T9
         OrdS9SYkidQ185axfnJmM8JfnsZVr7beMOOtSMZuMCGVJNyGSq1Ch/YdbxweIQo5fNb6
         zzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=AG5j6KdzOrOIZlpP/G9Y3cE+K8n2ovOPbsXUJ+7wxSo=;
        b=Xg6VxqFrMIeqrvM/IVLdVpseakdhz525uP3B1NJqlkmUQfBnJLiuNk+zReW+F4VRKS
         9x18apmzpjkcA3Rcca3i0GHGXXSLP7Jwrh0IDKJMur+Yh21XjBYw4P3jTIF7jWL5DgEk
         menuwuyBnc98fKahXZf/Qq7docE7um9W4piK/flAa8GO8qB1dcJ9UGYW+kS8M02EfaIz
         maA+mUfSoDqDoOyuq9sKyCDLw0ZhC0u6S07TmATliHB06xvCH/hWIIaBEFx4ZYFGQ4U/
         4S00SXULXF6yy0eA4xb2EVhqaQXgFf2i5Z9hHMI+L5TzFtv6oJeK1ngVxlCt3Ct4HIyj
         vQbw==
X-Gm-Message-State: AOAM531oKpzl2VSc+6SagjDunQVarsbUI4VSx2YR3cLmSYPYdsY9RrTo
        ddXa27sQUtBOd8enuyDcnHWSNA==
X-Google-Smtp-Source: ABdhPJy8eYSBSN1zLoF8WPrP3Ta3RaV5MISN51OJupxpC+nlzAgsQW/ZwYFm/vnBFekFzdFRpXnYtg==
X-Received: by 2002:a17:902:6903:b029:da:f458:798c with SMTP id j3-20020a1709026903b02900daf458798cmr8325001plk.68.1607644123398;
        Thu, 10 Dec 2020 15:48:43 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e5sm7184975pfc.76.2020.12.10.15.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:48:42 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:48:41 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Alexander Popov <alex.popov@linux.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        notify@kernel.org
Subject: Re: [PATCH] mm/slab: Perform init_on_free earlier
In-Reply-To: <20201210183729.1261524-1-alex.popov@linux.com>
Message-ID: <9c37ff7f-813d-3313-ea8a-fd65484e476a@google.com>
References: <20201210183729.1261524-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020, Alexander Popov wrote:

> Currently in CONFIG_SLAB init_on_free happens too late, and heap
> objects go to the heap quarantine not being erased.
> 
> Lets move init_on_free clearing before calling kasan_slab_free().
> In that case heap quarantine will store erased objects, similarly
> to CONFIG_SLUB=y behavior.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

Acked-by: David Rientjes <rientjes@google.com>
