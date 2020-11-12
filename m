Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538832B0A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgKLQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:33:58 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F06C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:33:58 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e5so3049983qvs.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/tmlBWdmWza/+n3zhUuqauLJsXCm75TWQTqBx06rWI=;
        b=TdU2t6+eTJT6WFCK6RlF5oFl5Aigtv2UUkzuW3APRnNigYuxNg9lkJszPABK9Rsmfg
         wM00gOrzldUq+P1FfpmY7aVdQHDwlFfSO1XOukWqQAYlka9USt1RM/ofEs3N+EhhwGtx
         HnCTSM7j8ZDL4Custv6w5iQZSUuR5jeRaxNym8mFtPEBv2KglrdWlDg8cCbGxx/jJFQm
         AAEadgsA3UgFrBrYJGVMO4bSHLIquSF6DHQB9rL4tt40ijoHCLdqnZzDo1N+J8Zpkx6U
         FhVvhSsLjmHfl4fSQ+I5DlTwkpRUX0889IVlsnnY9QEl59bif7kAyuh/r+kkOdpmsayM
         GSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/tmlBWdmWza/+n3zhUuqauLJsXCm75TWQTqBx06rWI=;
        b=CZlh8eSwJtIW/Iltqs4rFDBxm48jPRfSZGWXKV0KCbi+iVBWVjS01mjFF9tIbLfk0P
         G3n5WkR2iGfWfS7/giL4CvAo2VC3Wh5zLKUa+jD9kATc50iXtKmKH97dJ4Ik/9mnVetn
         Rb2VE6rfWARX/QSB2jzgKMA86gMuB80K1iJGthbrLnjbQlxy5tsnEofogRR6mzlvaqGL
         OKPa9NzOFsCerjD6ILfGJAYwtkcufMOW2U7/Qu+7E10umu67I7LTpoJKWuuQl305CSsR
         jEIg2VLa00o/ZutkyfB3/5jb+XcPAzQBQYI5mJg01Ie5JKWipaSQYqH/qdUH4CW7cHaY
         CBzQ==
X-Gm-Message-State: AOAM533pp0DUxpqHrnJbPW9GDu4srmMwhKpJK6kgAQYaLPXJFGQEbbSi
        /VeGj2WiOKfc+ayMLZ17IcJGxQ==
X-Google-Smtp-Source: ABdhPJxH8S4YxN0PJuazDPnJcN+igUFsoDfmY9n5mAfsKvIFqFJGC9lMuvS12++7XydgOpitsDIYbQ==
X-Received: by 2002:a0c:cb8f:: with SMTP id p15mr510384qvk.43.1605198835861;
        Thu, 12 Nov 2020 08:33:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:7257])
        by smtp.gmail.com with ESMTPSA id r204sm5082008qka.122.2020.11.12.08.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:33:55 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:32:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>, kernel-team@fb.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1 2/3] docs: cgroup-v1: reflect the deprecation of the
 non-hierarchical mode
Message-ID: <20201112163206.GD873621@cmpxchg.org>
References: <20201110220800.929549-1-guro@fb.com>
 <20201110220800.929549-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110220800.929549-3-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:07:59PM -0800, Roman Gushchin wrote:
> Update cgroup v1 docs after the deprecation of the non-hierarchical
> mode of the memory controller.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
