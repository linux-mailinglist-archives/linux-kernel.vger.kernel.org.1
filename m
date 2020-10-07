Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C316D28677E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgJGSjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgJGSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:39:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A25C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:39:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so3159700ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igZM3jEU+aFzJ/Spz32umO0y+Ys5Oai0gHignz/H8ps=;
        b=HV7/qkVSFo835HTJxMaJ1Yw2xZr2paOJi3thR59WWzvp7EZ+VEpWbJ25x184Nvj/Bz
         LAG1FD9gJh5zZm2KZLp1s1LxGDKOh/OHNjMS7PF7sUPgBjiaptYgDho9HwaKNKU9vAlm
         gXPHeaF5/RaXzTpEl0pCRtlGi2UYzNWfaNZinKaXPFL8w2nz5rHCPy/fF1R9x3cgMY1L
         zlBytLZsQqAJOKz2bhOQF1T2H9UUiBSgR3VRbHR4fMrAjGhtNDUGX2i4yGl8XdchdVg1
         gn6OK9kh+5cwUtM1PYVOOK7n9b/Qd9LwuSvA+FwbxALrX59+iPmUeQ86KaBYaF6UMWLn
         BjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igZM3jEU+aFzJ/Spz32umO0y+Ys5Oai0gHignz/H8ps=;
        b=azFNnZ0BktllcF7FYgkeZjbalw76RHq2h3wMnaKgkhzzXzy0qVl0UrPjSzh6vAHcKa
         J5kQnpYlNrJfU9iVTjJOXc5YABHNUgkYG5ZYNInrrz3+OAaN3ntNl7BMIAbpV6ohSSh1
         XLQHL37nTYmiCzUOd5eJRb7u0F6/ARs5ozw7blk6c2WyZ++AowhZRJaY9tnhvoJfnLkc
         7rXF5mG5gSP55sxiboFbQxwENPVKDm7//beUbYi4rjOAjmqx0kXUHW2+RCXFaQPl0h4U
         n8YXnC5KkvftrdR5DzGFrh565zedTXo+dip4oSkTicPNk7YtLj+94z22ok8SfiDqMlgT
         v+OQ==
X-Gm-Message-State: AOAM531OQ6TWZOlPxuJIzX94ipBVnZ2nCxQqUh5BQ/Ec44BbbEB0mXE/
        7OVZ9VT/5c28DJDqKMBaHBfZs/5qD8iH4qAl7ujb8Bdo6h5sAg==
X-Google-Smtp-Source: ABdhPJxaCAs/Naeu9Vj+uI/q3ssAAv8bT0Us3tz2UWmFKO/fzJurNlSBU76/AscJtztybSz+guyhqNIlsylbtHrDZJc=
X-Received: by 2002:a9d:6c4b:: with SMTP id g11mr1072527otq.265.1602095940663;
 Wed, 07 Oct 2020 11:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201007063315.41585-1-dwaipayanray1@gmail.com>
 <CABJPP5AEELQz0t2+34xYQOJ5e5nQzTUUU6UT8ZH0fqm-tacOmg@mail.gmail.com> <a2db6d34e964bd5ca65f59d1a536a61df71fc955.camel@perches.com>
In-Reply-To: <a2db6d34e964bd5ca65f59d1a536a61df71fc955.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 8 Oct 2020 00:08:37 +0530
Message-ID: <CABJPP5B_nscUwm4m+PySN67Cp=i1aR8KXKRuAf2YdAj_950j2Q@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 11:48 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-07 at 12:08 +0530, Dwaipayan Ray wrote:
> > On Wed, Oct 7, 2020 at 12:03 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > > The author signed-off-by checks are currently very vague.
> > > Cases like same name or same address are not handled separately.
>
> Likely now, the type should be changed from NO_AUTHOR_SIGN_OFF
> to a single something else for all the other types of messages.
>
>
Since BAD_SIGNOFF is being used for a different context, then
probably BAD_AUTHOR_SIGNOFF.

Should this work or anything else you have in mind?

Thanks,
Dwaipayan.
