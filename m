Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2412B0F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKLU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLU31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:29:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16FC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:29:19 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so7753220ljo.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5vf4lP9wnfH0LUzbBBcbdWfEQQ9TSKop8FfDOsd61Q0=;
        b=P+h9KuxPhuu1NTJNRN9kJ6Wmc8UU3NznYihiPyXBupeX4raR8Fpk52/3I3VuYiUVNr
         4BKWt4ZedxIhgt4FWtzH2/qsoPnmefgo/OjGrOVs9pFbApLdGjvSdHI0JwKcKsMKy06p
         6/edl4EnbSVclpkxbUbNX2EHoAJfWn/55CO1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5vf4lP9wnfH0LUzbBBcbdWfEQQ9TSKop8FfDOsd61Q0=;
        b=YvRENk6jOdZ0I6fWt2EO3VnipF2bRjhmvXUTTz7WlevFfoUUKIbu8l9S8CMpZ7D86A
         pmu60jB7UI9HvGJkQn3gMkUmCIV7ZHYJs+hTWokNUrHRVPNA1n3rt7X7xUgC9+KQQyyF
         vW8RCcCcu3FsUyZLAl7Bx+34Cmgapfi2VrFuWHMGmDg8NFvEwObqFcMImJ3HOPSq91LS
         rpfFEle1P8VTNKkUJUi35Jb1oikPBMwBv/S17mWQnUZp1SvjtLclCaGsLsCmMETur5Tq
         eq6I1V897Ig9lG/hnclIFgrQ5RRqLNYMyyNCj+Llkyz/+wixHVGyrZJ/0GAmXVVIV/It
         vXug==
X-Gm-Message-State: AOAM530pmJSjcETFqf8hkIUvS7X0GSw1Fv3xc6pUWVkCN9YV3EnA9N5j
        batbGF10FWFukyxWNXbuDneUGgyrMefJzlKCcNVTmnYz3SbBK/ZK
X-Google-Smtp-Source: ABdhPJx8vL6q4t437J/9H9nOcxD7k2iRyQ9ak4YEvh90L/tX/8ejTifHw6ttdjBsvo893UePV1C7nxP46h1hpkhI6Ew=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr533438ljk.466.1605212958196;
 Thu, 12 Nov 2020 12:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20201112200346.404864-1-kpsingh@chromium.org>
In-Reply-To: <20201112200346.404864-1-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 21:29:07 +0100
Message-ID: <CACYkzJ5ctN0wJfy5gWsR=+-DnmqaNZBF=QO8+FEB_qH4Sfm3=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] Sleepable LSM Hooks
To:     open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 9:03 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> # v1 -> v2
>
>   * Fixed typos and formatting errors.
>   * Added Andrii's ack.

Oops, I sent an older patch file which does not have Andrii's ack.
