Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65C124945E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 07:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgHSFWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 01:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:22:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD3C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 22:22:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h16so18144162oti.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJ5XL4OAU1V/azNwxmyVk5aqOXlfcvSspuaf/pZzbKg=;
        b=A33Fs11lkotZ2cL/TOAbIvb0wz9a8SKAngY13CSU1fcnt8eHBQeyOtasRj/ykJlpxd
         3F/WLu5OYRyS1AoJesRoYsbeTaOf7WfxCTWh254nXqDKmcjyBnvHOk5lrTGrr6cUOEI9
         mOHwu+E1TZN/4HwUbKD0gnPR1lc09+3R4w8g5X4LTmzvse89bUMqzP2Jtz9XZarHaxUF
         XxmWRAs1IQBxgCwB3wRAvGXbgBT5iUG5QIxTIkLKO8OB2dWPdyDjSc6bc9Cxn323favh
         VpEc2yw0juyL5kajhH4zzeclQLyVfb6M8RgLrMUrMGn+9ns0UBQSSXdjT0Ls9Km6i1EH
         ScMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJ5XL4OAU1V/azNwxmyVk5aqOXlfcvSspuaf/pZzbKg=;
        b=XOQ9LHBxMnhK0kvrNw9JJksPSVMWBUuM6vEUf9lfObEFoxtjJ4WcSvjrA0o8QJQqbn
         EJuP8GQWpuM7jGZ2TKA8yVdw9twQVKZ5g7cMMzLjpwuVL17POpmW0G/DzG5PDNMCMBoR
         3FaKKbSKsM42arBobChnVsPrYxnPqGxAJWfS3VF0Pg30X+UyroxFgaX4A66X/lGZ4QLA
         CSHNP9OtRePZRRMAQ9xvmnUiL0atzlBQVtZYVWEdCDzFF4PWWLc87YU4J/WFKsbnI1+f
         NXU6lanFCFUEGNtgzmrjSX7hMQF28zd9UzIIl4fuHG36tHNplQHpoHeFydfv6kCjyjnP
         UTOQ==
X-Gm-Message-State: AOAM531mnDOLmSwGCPDLKVIajU4K7vPef9zFr8IKDq63nn8Q7i1MiW4a
        EGKBTE0WdVeqFjNjJGMUe4x83oXJawqIUnr1Xac=
X-Google-Smtp-Source: ABdhPJx0urzsPqh9JxYiwe5iSpD3isQo81D5nL9cE4vfubQNULOY7NvU8qhwBydDK514ZsUwGM87NJEOhcU4ZdS8dJ0=
X-Received: by 2002:a05:6830:20d6:: with SMTP id z22mr17830262otq.94.1597814549522;
 Tue, 18 Aug 2020 22:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200818114323.58156-1-yuehaibing@huawei.com>
In-Reply-To: <20200818114323.58156-1-yuehaibing@huawei.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 19 Aug 2020 08:22:11 +0300
Message-ID: <CAOJsxLFTavwsoArmDh4NXtsih1U=n8K+Li4p5k-sJJZmKKx0ow@mail.gmail.com>
Subject: Re: [PATCH -next] mm: slab: Remove duplicate include
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, shakeelb@google.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 2:43 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
