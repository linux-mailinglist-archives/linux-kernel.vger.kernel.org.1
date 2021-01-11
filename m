Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4F2F0BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbhAKEB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbhAKEB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:01:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B9C0617A4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:00:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 23so35758780lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJ4oZj/INDOGnwb6v4auJzjxkzSmK4Y9iNf/0ZRDqNI=;
        b=gXF6Xa/OV0p3d+EOzlqzT0Rzd2VgQOAJs1YrI4FN8WMSGPN/+4eg5Mjn+1MbIPPqHZ
         DsK+STfi3ifThfPE799VS/zboEcre+IhTVLyVLvRum5aKhPoky2QuoCCcp0L4kf4Vmms
         mrGsqye93QAKDiVTjUju+7B3o1F87uL1Mj5qgk8z7wv1sNQ49FzIhAMLv2/SHMzNlmKU
         JQiHd2FNQAkGbCM/IIKnxF2VQ/RBEvGZXfXCPsw43Kl6AH70xVMbo5FTdl4gXZAtrNkN
         k0cFBDQkbThu9uZOmHzJ7C6D2jsasMFR3ojxdBBSEe62orLtaH7BglSQp1oGkrqWYCrb
         IIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJ4oZj/INDOGnwb6v4auJzjxkzSmK4Y9iNf/0ZRDqNI=;
        b=ZlGamRJNpt1x6iCFL32+Qf5hdobWjBU1LYfzGGF4UVQYxgD5UAYtSNx7q7G8uc+8/h
         kd1jP7iJCem2a/hbATstfyQjZIwdtWvnIVuJUPfXGDrG9k+lcc3TpALX9EBsD4S6CsEQ
         CuelmaoBNGRdxUXyTMTYhgMrTRtSrzWeuPpSu73cy/aBsVgJRLPmq4nxrxDQqtIBH3zf
         EJmyUXGIVwZYAOZ8qb0+A5q3NQDrZNQJwzW+RAWQd1VS9F5PzC5FoGeq5ZbRuXNwCXJ/
         UoUHaYO1i8mtD29bdvNLZ5iVELb/hO3FvCXa1ZAj16+1OAD7Wkiet+IOFfl21fYIcGYt
         Ew+w==
X-Gm-Message-State: AOAM531RjcD+dC/6FBOVbo81ixmGEsGUG99MMTUf8nhpuYN2T4D0E7zZ
        2Cq8WAtgWxDW1Aj54CrhnhqHWd9ZSFxXTN0iis4=
X-Google-Smtp-Source: ABdhPJyxexcmYUK6AFp1wmAkNNcByWYursh3kf4y22Cn6IyZ+Yz22D4PcrJUJneUSTj8zUGAudZG1CiWidUcH9n+ZVA=
X-Received: by 2002:ac2:5c08:: with SMTP id r8mr6257819lfp.12.1610337620830;
 Sun, 10 Jan 2021 20:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20210106034918.GA1154@open-light-1.localdomain>
 <20210106160827.GO13207@dhcp22.suse.cz> <CA+2MQi-pxRkaftawN=tMxDT7wWyXuS6ZjofcqK+2fwQ9LHvwfQ@mail.gmail.com>
 <f711ff53-4ba2-9474-73e8-48363a5157d7@redhat.com>
In-Reply-To: <f711ff53-4ba2-9474-73e8-48363a5157d7@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Mon, 11 Jan 2021 12:00:07 +0800
Message-ID: <CA+2MQi9wfyPD+E3sJdeONewRXENKsEi56bU8++DNZP=YPNDxJg@mail.gmail.com>
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> On Tue 05-01-21 22:49:21, Liang Li wrote:
> >>> hugetlb manages its page in hstate's free page list, not in buddy
> >>> system, this patch try to make it works for hugetlbfs. It canbe
> >>> used for memory overcommit in virtualization and hugetlb pre zero
> >>> out.
> >>
> >> David has layed down some more fundamental questions in the reply to the
> >> cover letter (btw. can you fix your scripts to send patches and make all
> >> the patches to be in reply to the cover letter please?). But I would
> >
> > Do you mean attach the patches in the email for the cover letter ?
>
> You should be using "git format-patch --cover-letter . .." followed by
> "git send-email ...", so the end result is a nicely structured thread.
>

I got it.  Thanks!

Liang
