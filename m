Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E12980D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414556AbgJYInJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgJYInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:43:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8AAC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 01:43:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z23so2123817oic.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLzorS3TcgRe0ZBnPGj0ERMoN5Ek0iJXkA9guMm2xqQ=;
        b=DRwLy3nL46RKVhP5wEmCcsJSQuZSSCU+HrydmZ0fQsT/cnaX8ID8TDU9DAkU+stR2O
         vd3qkqY29FIULYVK4QJCzyYv8XmXBSZflhWqs/c45rT6dKG8DvVmY3vutsIxOF5Jdjbe
         jP7CSHPY4DQkqYfi5LPbFPb8wb4eQOGmEFbWjyxcnBMZuYTlU6DZKjfSui0OJQRFZYCu
         ECNicMF5h78dFW6dMlejakvN8meWU/Hgtd+VzqYwrsHP3DUcdF6i6rRK3gyVFAiFp+t6
         qI4aWKIIBUfeXzvOgpe4jffrGuyrGgYizTlwYyRQ+RGbH3PFHYMVQBRzaRVswZJHpcLc
         YVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLzorS3TcgRe0ZBnPGj0ERMoN5Ek0iJXkA9guMm2xqQ=;
        b=uAvEzJj1QLc4hOco/crTpmuDBe7QauAdoJTY7dsrjSVksDIL7ljBbsC4Nj5tPXUqOT
         4IFbpi8L3t72YkRSzRe0G25ElVJlFn+l0174f219Nq+Cr4IbJ/gsWSswF+JsLqkXZ/EI
         mf/pQG06kyIjHrcpIP4c8iBgu9cuea5u5kDw+1RnzAiXMU1/eCbprzKyd2OCNH4oKLU2
         kYnJE5kLnjO6MFMlzSRsrXWfV5eppUAMeL8QiuQ1xf9PPiFvM5ewEZw+tFhi5KwK9G5f
         he2HUVomf85wOosr8fc0/fwM0hOdyjFq6PM24uWyOvHXPMST338BdKW75jGVP3UUsHof
         4EVQ==
X-Gm-Message-State: AOAM532kilGUvDfye6qNdlvStOO4HZ3FAYi8djfmxe4D89p0rywb1p4w
        KPPoJijiuqwgcwJaGd051bm/zWszg14q5FI8/y0=
X-Google-Smtp-Source: ABdhPJzXIU8lyPwuASWHr3WR6PJ41ohdF+Jw64aaSvj5VBv1HjvHVgs8gqGFa8T4AyBiPxapLNu3b2pVaOBpNo2Rr2I=
X-Received: by 2002:aca:d5d2:: with SMTP id m201mr8356150oig.74.1603615387747;
 Sun, 25 Oct 2020 01:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201025065134.21737-1-dwaipayanray1@gmail.com>
 <e96f8306d57e9a2ce7118b545db197e819e97b19.camel@perches.com>
 <CABJPP5D9ziuyPpPPyPM+n101vT1LGEjHj+JQjOhdN533t8Ud7w@mail.gmail.com> <80280a389782858c72fcd56a54da1a1f4153216c.camel@perches.com>
In-Reply-To: <80280a389782858c72fcd56a54da1a1f4153216c.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 25 Oct 2020 14:12:38 +0530
Message-ID: <CABJPP5AY7Vm4CBhhnqYo_LWFYY6PB2fgtk6CLR3tUEV1ZJNQpg@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 2:08 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-10-25 at 14:02 +0530, Dwaipayan Ray wrote:
> > And also do you think there should be a separate check
> > for __alias__(#symbol)? I think it expects a string and that should
> > be trimmed in the fix.
>
> For now, I think you should avoid both alias and section.
>
> There are patches to convert both of these macros to remove
> the stringify.
>
>
Okay I will do that.

And another quick question please.
Suppose we have non handled attributes in one such
multi attribute macro. (not present in our hash)

Like __attribute__((__packed, __something_not_handled))

For this case, do I skip the warning totally? Or something else?

Thanks,
Dwaipayan.
