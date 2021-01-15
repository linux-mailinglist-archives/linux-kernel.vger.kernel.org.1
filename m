Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF32F6FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbhAOBYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbhAOBX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:23:59 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A15C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:23:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c132so4991579pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Nuw9usw0vxK8JD4tBT70Yn4lhH4gOj/XaaGUqb4BaE=;
        b=FbU886KZrJyOI4IkY+mSvN4dU54Vi5z9wX8ScVy+WjwzehHKpM6A1mlWnvRxv3gHoi
         NyTFhMnHM6+0KeyJ3xfyW4ES9XlAHf+IQ9kIHrUy5Jq0sAuWg4OyCIr6B4ISh1tvXfrB
         zRYVrca0JPFgr44vrvxKnjTjbj31dda5+uUj5aonIxeD/ja2TMo+dmKxaRCQvKwYee0p
         FlA8rC5QDqcWUWiuh1EJZz5Tm6leF9D3KB7POq1QOUerKWX1Wq1N/6mv7qSBIB3nNb1/
         ovmsh5P+xFzXI1BU/3W2QYklaDRWxgXkWvvnrCoPUBPbtYywIiOiT6DBab6sRZkXdb0f
         Y6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Nuw9usw0vxK8JD4tBT70Yn4lhH4gOj/XaaGUqb4BaE=;
        b=eJxlN5jsSytgTV3f6VHvnXqLAQcD58S2u0IeIbsYTmKDiy+NASqj7TGyZK14zMImgC
         JL87MMxTVaR6OjZlq7tmwsjVqbhCfdLa57RPNs+jwXVwQNTX5uKeuHY0B/9P+4cEDKdN
         0uIW+DwjNcfkRHZgdU9HDIgVdPG2gzHA+z0wlQUEi2JmTX5cOYG9vT2qxoPsYyFxP4mE
         fWZnvzfuK6InCe4G8T5M9fCJ+lpe4uiRNtAGs2Cyuot3ZfCwe7SY7zX/GSCW3jGIQAjO
         NQeo8+ds+nAygFP67bibu2jaI2WwhkT/l8EQ8oyoLrgOSEnWda1DuEpTEsizw4+mS3Wj
         ie4A==
X-Gm-Message-State: AOAM53146UvlscTBBkFH9PPkJq5QsusBA6qYw13CD08wk1iBRh7WiO5Z
        IYGUn6nmnnpHXOnE6r/EVMZ0eVUyVsHHty4V5sbM9f0E
X-Google-Smtp-Source: ABdhPJxK+LFZSeZ1lko6pCTRs3w/M11yHcav5S9ILAMuMSJ4VFhPIc7OCxJb2ufLonhBLl/8gq1xxII26K5sdgx+BBg=
X-Received: by 2002:a63:1519:: with SMTP id v25mr10262466pgl.217.1610673799229;
 Thu, 14 Jan 2021 17:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20210115002134.117637-1-dave@stgolabs.net>
In-Reply-To: <20210115002134.117637-1-dave@stgolabs.net>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 14 Jan 2021 19:23:08 -0600
Message-ID: <CABb+yY381GYcfAkLuzSTvNz2yHGs4Ap7Kgwiy9r0pXGGQt+ozg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: bcm: Replace tasklet with threaded irq
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 6:21 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Tasklets have long been deprecated as being too heavy on the system
> by running in irq context - and this is not a performance critical
> path. If a higher priority process wants to run, it must wait for
> the tasklet to finish before doing so.
>
> Use a more suitable alternative such as threaded irqs and do the
> async work in process context.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
Please cc the author and other contributors to this file, esp when
this is vendor specific code.

thanks.
