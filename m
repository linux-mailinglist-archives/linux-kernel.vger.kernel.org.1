Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4462AC396
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgKISVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKISVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:21:00 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810DBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:20:58 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so5508301ljh.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWLWa7SPKs7GPknksKLCZ9SBMpZmS7lY4U8JqE+JC8A=;
        b=cl+PlEyZsk5U4kRGAKvFGA45cDIFPb/m73dsIGArh7ozhs6BJiefaaJA5RYzDRDcWv
         yCBiINhPOFqA/RQjmjg33pIcKQTP7Fk80jlJaTYPFN4XhC3nFJzse2Oe5JcnXXyieqMW
         ITrWi5Iv+S36B8j8SQ5RHs8nZey6JFtr1NQufErxYbAx5vh7vtZVrQ6i2lhtTP+uzXYk
         8SVsVsbEbW/pbsubmAt+NeSC61yHTMNbowngDRMR3rceqCe4miCTsHnBhad16infg4gW
         CqrWVM6rG99eOEcIv1CWcRRt4izVYR3jl+GYZ03dVZsWG+3pwoYqGpuL64VkmGs7ni6/
         h0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWLWa7SPKs7GPknksKLCZ9SBMpZmS7lY4U8JqE+JC8A=;
        b=HsTFg6hSTKjAMXBP1opfD3TXnRuSIzSLCmgzv9xziV0qV9PKK9zo3Uuxs7a3nq2hH9
         bAJ4NqXf41qlkhYniuz7wx+/uQM1oM9loZ30zpj7boUu5hphgZaeQjXDSN4n4RVZ4Iup
         pZaO6T1cHjaomL+SW0aX12/30/M/omKK5QTfgpO+I86r44PyIiE4Eieec3ujz8UcZIyU
         lfNZHoaEtHF04UQEzZFYBUMIgUn71eRT5GrpoazIm9KjDON8tIE3vzob6wFwtWWXbKQT
         gN8DEVaDyJh1rEF6LMu+/sA2fx3BRPSqb3Ef6E68FeXam80OYAlSiuXn1IH6EBHNi4DS
         Og+A==
X-Gm-Message-State: AOAM530CjSdYMQNxCMu0KQNenWS3jn4z/2caRTZUkQK3o8QFGlMXm5zT
        iVkc2WFnu3eEjeGCP8FGgrAYDKGOnu1Q1mb6rY8kymFajPE=
X-Google-Smtp-Source: ABdhPJy8dXBEu19X3GHc4E5eM4lK6fxQnh3Gb/2H1WcGyzhJ+mj82aM9DSbv0VHl2/uz+XfjtgldShSvtgysXXRbzDU=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr6942637ljj.270.1604946056700;
 Mon, 09 Nov 2020 10:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20201108003834.12669-1-richard.weiyang@gmail.com>
In-Reply-To: <20201108003834.12669-1-richard.weiyang@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 9 Nov 2020 10:20:45 -0800
Message-ID: <CALvZod7UAm_E1A7q55fsUH8zq6u273u1_aAVDTBhsYW_Dhq_NA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: remove unused definitions
To:     Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+LKML and linux-mm

On Sat, Nov 7, 2020 at 4:38 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> Some definitions are left unused, just clean them.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
