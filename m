Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2821FC995
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFQJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:13:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39938C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:13:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so978525pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gAYnBirOibvZD28fzMVr6eBnxdlYq8UdtZIty2eARKQ=;
        b=VYkh1yeYhdUyCPucPOu10xX/RKtBH0OSbLxEkVY0rPHTbUoZPH1tu6z9D8vK77lnrs
         xzmDgReTiopsY74MH6RVw4jFjP9YNfHQfRQSy1hKWBkgcehJ3w/R3jqEytluA0GHDTpy
         BGlaL9ruS5pzKTGwFKMT8P371xU11hMLjExyvTlGpNI62ZQGUsd78WF1qNLs5/oqq6MG
         9YJTqoZ8A4apRTGhguTFrk4djlWXP8LbJj1UE176VAMiYRFCrslbgwz6C3lnIcp7u276
         YLNIpxI/bo8UKatx1lq9/dIqwjwXjsStR3otuhPw4gH0/ql3JfzNLiDMlleY00DobyGk
         bTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gAYnBirOibvZD28fzMVr6eBnxdlYq8UdtZIty2eARKQ=;
        b=WQyF3qI/BXe9zuhevXvRY1HCWu2mrst7jhM/Otijb25AOePPNdsaENxovuAJ4lhCAp
         kz/Q887+eNR0PGefadDWv3nbzMCsDxnQpl4C0ezi4xFQZMbTPeVIaDZ/1G3KLZ0M/meq
         SSsl+wrlOMi9DlpNivS0PIoCqUBRxXG1hjTAHcW9ImN7XSOqh+fCqmLntb0JY9RTPIN6
         KpQxUfhJfit+8Iium4igacVoNcyx3oatrAFpDOs451TYKYXgZhp8ygMy6qYS/7U7EcGF
         5jzSPuDu64Z4nEsNb0TK+QYCg+gxXRRgb+MF7/fHZ63Kd1dSgK/K5s+a4q+hRNOhuDI1
         KrBA==
X-Gm-Message-State: AOAM533WoZLxv0agCfPGsSoWfom14MkgGl0BRMy4bBPsztbou8HwC8Di
        RPPGxmLA0M+Uft3aWPpvKt2Xq1tnFFc=
X-Google-Smtp-Source: ABdhPJyzAWj60tHMNwPcSwVmov5Jsn9l6pLvEoPWpuIG91qGd5fyC/dG62cHCRWBFY6zC68t6eD5kA==
X-Received: by 2002:a63:d848:: with SMTP id k8mr4974628pgj.82.1592385195558;
        Wed, 17 Jun 2020 02:13:15 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id b191sm17253146pga.13.2020.06.17.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:13:14 -0700 (PDT)
Date:   Wed, 17 Jun 2020 18:13:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: Fix oops caused when dumping stack
Message-ID: <20200617091308.GD1401039@lianli.shorne-pla.net>
References: <20200617090702.1684812-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617090702.1684812-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:07:01PM +0900, Stafford Horne wrote:
> When dumping a stack siwth 'cat /proc/1/stack' the kernel would oops.

I will fix this typo, s/siwth/with/.

-Stafford

