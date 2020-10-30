Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD52A0AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgJ3QO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3QOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:14:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:14:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p5so9396210ejj.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mTAgO+8zlS2jG7dBiBCWSd26SLHIZqlQuA1CoNlQvw=;
        b=1F2+oyz863sC0wPvcmPAoUPbi2kfTu8tJ2OGXJ3eFQEe3nBTJo0x/TYz481PUVqPyD
         Bs0y4uKeG2uW7QaNydVQTr0lDJgYNrp6iEeuv3VXQNe237wXrvXj9QKoJyf/lwvpqfkN
         9EfIb4RSNOFOlBTeeA1cceEARJIk2Djuh+ckV5RLf/4Q+eg3YsjHQXyrFsRedyZTWvbL
         BWSaL2OsgGxfyA+oRzk8jMFeXMocOW0y+OgHN7+x8Oo4Uc62Og3ZZpbB4rsLBqoa+6te
         sXjWqLgNbIxKJB4Unh8Qwr0kW6jpxgJbliFZBz5X2oPBsmhaaFJZ8tyMTu+ESBiuD7Hg
         AvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mTAgO+8zlS2jG7dBiBCWSd26SLHIZqlQuA1CoNlQvw=;
        b=A7xs9gFYNWbCnqqjfjBWjld7kEqH4yD1UYTp1KzF0cDG1a7lsEkPmN/0NBybihk4V3
         8JpLXi5WWgP2kwBbM29gfm3VRvSlV/Simhdbj82Hxz2KM+B4FZ2Cv14UG03STxylj21S
         t711tTfKU1WpT9HIhpGMB9s0rurFqJnSdJpq/7z4pD0ed2kcIsie/T+cJ2XL6Wf7l9Tr
         +jfmEIZ7TBTL7gw9v87l+/Tsut0PfODY33oqlPX7MIj4Yett1vZjepaVLkRDIK+f31RW
         P3B0FxZ5/weU+imcnLTU+BFtUo9ackO+GwS4L3wTbycTcGB/wfUR2hI5GppW7OsQ8jiM
         0XAQ==
X-Gm-Message-State: AOAM530mYklxOWPKhJH+x9LLU2deBXz1LKptsfpXpQUrZLNViRlJdKG6
        ebjvozEbc6wCawUeKDqqVlnb7v1O6eWeF6dBHB/N
X-Google-Smtp-Source: ABdhPJzlMfJmGfuu/nI0CJHjBC4EFvaOkY4L4j3Ea0u2Q3hh6c5UbuHZBL0ZaAj76HMuJWk1EwewQn8eLO0TDyRvBZs=
X-Received: by 2002:a17:906:25cc:: with SMTP id n12mr3124699ejb.488.1604074492111;
 Fri, 30 Oct 2020 09:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201028020615.8789-1-chenjun102@huawei.com> <c2eba2fb-79f8-eb48-ddd1-77fbc205ebff@schaufler-ca.com>
 <c9e1646e-f242-4d76-f482-f6281585860e@huawei.com> <70f2c67a-eb8a-5c28-9f78-838b397370b3@schaufler-ca.com>
In-Reply-To: <70f2c67a-eb8a-5c28-9f78-838b397370b3@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Oct 2020 12:14:40 -0400
Message-ID: <CAHC9VhR_mCQ=amJbVRC_F=B+aCwRkjirYKQ+9ehktKy1Ji9Sng@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: Fix kmemleak after disabling selinux runtime
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Hou Tao <houtao1@huawei.com>, Chen Jun <chenjun102@huawei.com>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, rui.xiang@huawei.com,
        guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 8:34 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/30/2020 12:57 AM, Hou Tao wrote:
> > Hi,
> >
> > On 2020/10/29 0:29, Casey Schaufler wrote:
> >> On 10/27/2020 7:06 PM, Chen Jun wrote:
> >>> From: Chen Jun <c00424029@huawei.com>
> >>>
> >>> Kmemleak will report a problem after using
> >>> "echo 1 > /sys/fs/selinux/disable" to disable selinux on runtime.
> >> Runtime disable of SELinux has been deprecated. It would be
> >> wasteful to make these changes in support of a facility that
> >> is going away.
> >>
> > But this sysfs file will still be present and workable on LTS kernel versions, so
> > is the proposed fixe OK for these LTS kernel versions ?
>
> It's not my call to make. Paul Moore has the voice that matters here.
> I think that the trivial memory leak here is inconsequential compared
> to the overhead you're introducing by leaving the NO_DEL hooks enabled.

Disabling SELinux at runtime is deprecated and will be removed in a
future release, check the
Documentation/ABI/obsolete/sysfs-selinux-disable in Linus' current
tree for details.  The recommended way to disable SELinux is at boot
using the kernel command line, as described in the deprecation text:

  The preferred method of disabling SELinux is via the "selinux=0" boot
  parameter, but the selinuxfs "disable" node was created to make it
  easier for systems with primitive bootloaders that did not allow for
  easy modification of the kernel command line.  Unfortunately, allowing
  for SELinux to be disabled at runtime makes it difficult to secure the
  kernel's LSM hooks using the "__ro_after_init" feature.

  Thankfully, the need for the SELinux runtime disable appears to be
  gone, the default Kconfig configuration disables this selinuxfs node,
  and only one of the major distributions, Fedora, supports disabling
  SELinux at runtime.  Fedora is in the process of removing the
  selinuxfs "disable" node and once that is complete we will start the
  slow process of removing this code from the kernel.

Because of the upcoming removal as well as the drawbacks and minimal
gains provided by the patch in this thread, I would recommend against
merging this patch.  I would further recommend that distros and those
building their own kernels leave CONFIG_SECURITY_SELINUX_DISABLE
disabled and use the kernel command line instead.

NACK.

-- 
paul moore
www.paul-moore.com
