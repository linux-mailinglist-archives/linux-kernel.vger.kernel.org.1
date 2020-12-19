Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25692DEC9E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 02:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgLSBVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 20:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLSBVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 20:21:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177BC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 17:21:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m5so4619838wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 17:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUtnZhHSTUhn7PA1a2z6Lv/RpUDz4hHMbvf4C1DMOfc=;
        b=YaVJY5BPLRUSLWuB/cxB1XSe7pxQ1AXuAlzSwdah3s4vyu8h4CO86lmqEr6swWRSe1
         Vpm3YZqPQUcDuIS3a6fLgT4hsXqlZPzc6gVj07by6lEuzoqu+94s2uWuaPOPQgotDEmY
         NVaXL9dwI1gwCmLZekV8lPfWAU8GnRQhlFM6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUtnZhHSTUhn7PA1a2z6Lv/RpUDz4hHMbvf4C1DMOfc=;
        b=Q6LOCzKyLQanZE3dP7TEtr34ZhAbaZImrrn8zBW5uE47tAV1LDIJxTEBJeh6FWlHVd
         O++TePW/4kFWJQzCg4p1lqzWWjSWlAivVPFLpTMaedar1Mw3O7kZ3a7TgAcQ2N97VjUM
         ElKaZoBPWXC7z7DBjJDmCvsN++ogk/GdQcFsbFR0spv2HuaYRMNBRFBWciop1cSzMyPx
         4g3F23KjdrRX22KRuEZnNsRxCuE50/mLJZvF+JwvObguzKkvEgdNHgNEVFtbcmubGhbg
         FMCl53r6IjH0Vha1/BAzkBRGiu1o+p51vyKuPGKpmpu3To3Q2DG3nns+ll7O4+Ej40kr
         mDfQ==
X-Gm-Message-State: AOAM531s7x1vu/HRqget+666HXAHF0tTFmCFOeYng8MHfem0SHFyluVb
        smHmu69QEMPIEAnQKb4zn6oX+/wfDaMt6g64
X-Google-Smtp-Source: ABdhPJynQVDYY3wR0uqszBcpsiw1KNTrdA8q7tIzm8L4dfhCfXyQ8SjCK8ODDXIQuDs6/mq9XojkfQ==
X-Received: by 2002:a5d:55c6:: with SMTP id i6mr7005610wrw.137.1608340868526;
        Fri, 18 Dec 2020 17:21:08 -0800 (PST)
Received: from localhost ([85.255.236.29])
        by smtp.gmail.com with ESMTPSA id f7sm19268615wmc.1.2020.12.18.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 17:21:08 -0800 (PST)
Date:   Sat, 19 Dec 2020 01:21:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Jacob Wen <jian.w.wen@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
Message-ID: <X91Vg1Mg1nPk/Bsx@chrisdown.name>
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
 <20201218105153.GX32193@dhcp22.suse.cz>
 <f376b551-9a90-c036-d34b-b32d93107b6c@oracle.com>
 <20201218142717.GA32193@dhcp22.suse.cz>
 <63e8a821-a3f6-47a6-f438-b27c32f4a05f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <63e8a821-a3f6-47a6-f438-b27c32f4a05f@oracle.com>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob Wen writes:
>set_task_reclaim_state() is a function with 3 lines of code of which 2 
>lines contain WARN_ON_ONCE.
>
>I am not comfortable with the current repetition.

Ok, but could you please go into _why_ others should feel that way too? There 
are equally also reasons to err on the side of leaving code as-is -- since we 
know it already works, and this code generally has pretty high inertia -- and 
avoid mutation of code without concrete description of the benefits.
