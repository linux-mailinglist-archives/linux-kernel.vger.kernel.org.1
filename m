Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91033274731
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:05:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgIVRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:05:09 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kKlj1-0001L3-6l
        for linux-kernel@vger.kernel.org; Tue, 22 Sep 2020 17:05:07 +0000
Received: by mail-ej1-f70.google.com with SMTP id w17so6486841eja.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oksNI5rJodtO2H9Q99QSOgu/CDadI0WohvaQe2JU2Oc=;
        b=hVEailp1d1YQEE0YMq8pJphPguDBh+RPgh7fo+SlZrpCCeJtuGXjR4mcHbxDfoGRjw
         /qW0MCYbKhI5n6hpTy7QLWdiGbEjrHbCMvO9DGBjjPOS8BgvZkwj+aEf079nUvhMo/CF
         uFQSUMdpajdBZVSFYwVuB3F//oFR60/a6cEz/MzItt5K0jZjSXBdjiaSKHNyQBZouonK
         zTTuvF21RCbrTMVaLN894ZWifm+AgQuSC8WBD0JowJkDU5wCRt983BJibgcyQwh24RAD
         QjHmoif5786ewxqUVEwK+oswnHtswcKHz6EnZExHZ7Ep1ExQVQFLSkNPdjx1iaTy4wq4
         nAMQ==
X-Gm-Message-State: AOAM5307/MiPODmfNKa2AbMCHaqhVrmYKK3PUMpJIoNMPivvRFmaVuMh
        7i/1BsJdNthvE4NDZNkg2WrZk6oYEgznkVBt/qpm+c3cqLWcFjfoDnbawdi+zJFR9fGVR7X2SKU
        4ZiEzHPtfX4dAJB28j15sK0M1IBJYE2xt4WH5i+Sy4+Ff6HU0DR6HabGyJg==
X-Received: by 2002:a05:6402:6c9:: with SMTP id n9mr4929978edy.297.1600794306814;
        Tue, 22 Sep 2020 10:05:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyEszi51KsIDcxGIzsJjOCWobko0JYsVTgDmtexJ3W2in7ThmVI/QA7F8QhcR/g+HFRueM87KcRQ2Q7iHvT14=
X-Received: by 2002:a05:6402:6c9:: with SMTP id n9mr4929958edy.297.1600794306614;
 Tue, 22 Sep 2020 10:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com> <20200922125809.66690d54@ibm> <7ee09899-6724-e932-f73d-d49da0fb4a9d@oracle.com>
In-Reply-To: <7ee09899-6724-e932-f73d-d49da0fb4a9d@oracle.com>
From:   "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Date:   Tue, 22 Sep 2020 14:04:30 -0300
Message-ID: <CAHD1Q_x8TQA7xMxbm0LaP-nBd0d++Ox7dQ9+2PsDfe3S+=nKHw@mail.gmail.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
To:     boris.ostrovsky@oracle.com
Cc:     Philipp Rudo <prudo@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Baoquan He <bhe@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:53 AM <boris.ostrovsky@oracle.com> wrote:
>
>
> On 9/22/20 6:58 AM, Philipp Rudo wrote:
> >
> > AFAIK pstore requires UEFI to work. So what's the point to enable it on non-UEFI
> > systems?
>
>
> I don't think UEFI is required, ERST can specify its own backend. And that, in fact, can be quite useful in virtualization scenarios (especially in cases of direct boot, when there is no OVMF)
>
>
> -boris

There is ramoops backend too - I was able to collect a dmesg in a
cloud provider using that!
