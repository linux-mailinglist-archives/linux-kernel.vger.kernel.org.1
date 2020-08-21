Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D924024E1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 22:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHUUOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgHUUOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:14:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA016C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:13:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d11so3621209ejt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BtYd9/pAyG1sqGYcTy0rM8tdo0b9K0n3vpfXHvN2DE=;
        b=j1MIxYG+ikKdio/J7EEBu7O+TNel4fKx2ssCXBwf1QibUwKRpqucOcuBx8WB9+MiBp
         yWrpVaS2g4Or8Vsgeq38loMK2o7Ehei2ZhGdshzTafjfyQPoSREWCiy0QXYZYfRIFhsT
         rTX73zkaUPpfX9PRT8k7hafwBU0/ZL0kTf0UUf4nCTb6d68XXCqd64OJIKfV2JWombm8
         WTvRKC3G/CXx75X6/3nsms/N8S8lVzAnUwH06hP72mPQZLr6XxUyXRvWSt0dEEaBoIAL
         5jICYw/OQX1fLwvVhaTNQEe18HTXI5YoEY/jhuo+AvRywFaNHSFUfJHBfv8LqQl2sIo2
         vCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BtYd9/pAyG1sqGYcTy0rM8tdo0b9K0n3vpfXHvN2DE=;
        b=afpiJx8E8YIbiUvhB0XSJZNh8rsEX97nXyO2wsbkbcSD/+3kHr59FBKvI8gljZA4xV
         v2huD5xaiA1BHkB63p6HT/JYdNdFPbk1miM7XNjATFFqC+4NsFazizLNO8f45Ai3KNjt
         P1My5axPAZyaps6iugRrjSah40q/6XgT0OWAssiDKTrEBBQpVyCLtXsBeLNqQ/Jb5KU6
         4TMuwb6qbssR6VST1JqFkNV4PlPfYjn4oClq/tKuGFlk095ChnWjE+Xbr2MoYYeH9GJK
         0SpBm9yE76S0uNK/KSL0KklMXjt7/5ZfBFXP4ecWuJjNHDbuYaMzNT//OjVRKtLAq5kR
         xEqQ==
X-Gm-Message-State: AOAM531NH9sTN4dpAFT+8LS1WsQe0TE8XZlHuealsBAUEBK4iWSEM2GY
        dyFyjPeFjEYk3HmHNsk5ajRC7m6dCk7bUx1ojwSg
X-Google-Smtp-Source: ABdhPJyd88CfX7VJaFvZK1tKg0a4ztk8lkZlg+SopdBDlMcFpbfuejWoSXXNsA00gY0qnev4OvuNLAl+o4ySJ/3jueM=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr4526810ejn.542.1598040837725;
 Fri, 21 Aug 2020 13:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <01229b93733d9baf6ac9bb0cc243eeb08ad579cd.1593198710.git.rgb@redhat.com>
 <CAHC9VhT6cLxxws_pYWcL=mWe786xPoTTFfPZ1=P4hx4V3nytXA@mail.gmail.com> <20200807171025.523i2sxfyfl7dfjy@madcap2.tricolour.ca>
In-Reply-To: <20200807171025.523i2sxfyfl7dfjy@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 16:13:45 -0400
Message-ID: <CAHC9VhQ3MVUY8Zs4GNXdaqhiPJBzHW_YcCe=DghAgo7g6yrNBw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 11/13] audit: contid check descendancy and nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>, aris@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 1:10 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-07-05 11:11, Paul Moore wrote:
> > On Sat, Jun 27, 2020 at 9:23 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Require the target task to be a descendant of the container
> > > orchestrator/engine.

If you want to get formal about this, you need to define "target" in
the sentence above.  Target of what?

FWIW, I read the above to basically mean that a task can only set the
audit container ID of processes which are beneath it in the "process
tree" where the "process tree" is defined as the relationship between
a parent and children processes such that the children processes are
branches below the parent process.

I have no problem with that, with the understanding that nesting
complicates it somewhat.  For example, this isn't true when one of the
children is a nested orchestrator, is it?

> > > You would only change the audit container ID from one set or inherited
> > > value to another if you were nesting containers.

I thought we decided we were going to allow an orchestrator to move a
process between audit container IDs, yes?  no?

> > > If changing the contid, the container orchestrator/engine must be a
> > > descendant and not same orchestrator as the one that set it so it is not
> > > possible to change the contid of another orchestrator's container.

Try rephrasing the above please, it isn't clear to me what you are
trying to say.

> Are we able to agree on the premises above?  Is anything asserted that
> should not be and is there anything missing?

See above.

If you want to go back to the definitions/assumptions stage, it
probably isn't worth worrying about the other comments until we get
the above sorted.

-- 
paul moore
www.paul-moore.com
