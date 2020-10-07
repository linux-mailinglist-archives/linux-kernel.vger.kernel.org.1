Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1A286B55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 01:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgJGW74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 18:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbgJGW7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 18:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602111594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9c9S4SWxbR/XjvJgV1ymG/+riVpePux161h+CAa6XqI=;
        b=h5D7EDAw3vRDCzlLsCMZzpLvMGWMFn6gCOgWGkm9uKpcYe/mklMX98nUHntWofYDmDQ7ne
        pj16PgBZ6BlhGEm1Gbw2EaZhbJqf7/w8eoWucEIfOeNkf8NUtlCimmQjuTYeO9OTikE07S
        xIbVv5xfdE1mRScLpcYZ7dUZ94bKq3s=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Ca0UBnXiM-OcsqDO6jH6Nw-1; Wed, 07 Oct 2020 18:59:53 -0400
X-MC-Unique: Ca0UBnXiM-OcsqDO6jH6Nw-1
Received: by mail-oo1-f69.google.com with SMTP id q75so1698631ooq.16
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 15:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9c9S4SWxbR/XjvJgV1ymG/+riVpePux161h+CAa6XqI=;
        b=TZrVAhoY0cjpQEB1nSvj10MNEXmZtrgufBUoeqL8qCurKPr+a9ljJIRdI+BfRA0CqU
         PWV5kNa6DcdS3IcAfEMAmZWsRVx/fkQDWaK/ngK1g/19wH6FjT4S/bVlnz8UiZrakraw
         ansfrtlzyEAQQXWMAU07zlf6X1KhTDi2gAusTq/bS909xanOp71dXMumSdNxnlOcJ6HT
         S2Rmup73OR1TT2G2f8g1fcjSUXnkdQN3TIaRz6YreviiDg6/HqeZm7CzSnz49UMKkf1s
         EvpV8Qqpr1zLFZjzlKy7waqlH8zUyVqGGPR4+asubt6wz1D1gny0wFzimlPRbejz7lXx
         o1Ig==
X-Gm-Message-State: AOAM532+LMsN75in2cUjBtLRUwIacBWE6ZDxE1J8rmENOqyDptPCFnKp
        l/Wy/HFARu/ndTy2xGJQnet3HHbZjUfnkJP26xt/0ry6k8lfblrQg7ibKt12+wGnxZ9X13dCUM3
        zCGmqKJmGemkl+7FqJTdbIRA3LAnf2I29fht4bcCA
X-Received: by 2002:a9d:6645:: with SMTP id q5mr3307299otm.172.1602111592157;
        Wed, 07 Oct 2020 15:59:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1KrevTuJVjt3NgOB/LB+vZ+qvcmIrgXsSuR0YnpmgF/WC3wEbanx1gqBRbc/BBYE5oIdAHWDziNUURQeMtvE=
X-Received: by 2002:a9d:6645:: with SMTP id q5mr3307288otm.172.1602111591924;
 Wed, 07 Oct 2020 15:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201007181409.1275639-1-jarod@redhat.com> <20201007181409.1275639-6-jarod@redhat.com>
In-Reply-To: <20201007181409.1275639-6-jarod@redhat.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 7 Oct 2020 18:59:41 -0400
Message-ID: <CAKfmpSeSWNKEoxtYP9sY30wDUFaSAk76GghmBhTefLo07ThHiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] bonding: update Documentation for
 port/bond terminology
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 2:14 PM Jarod Wilson <jarod@redhat.com> wrote:
>
> Swap in port/bond terminology where appropriate, leaving all legacy sysfs
> and procfs interface mentions in place, but marked as deprecated.
> Additionally, add more netlink/iproute2 documentation, and note that this
> is the preferred method of interfacing with the bonding driver. While
> we're at it, also make some mention of NetworkManager's existence.

I neglected to update the ToC and put in some leading #'s that I
should have, so there will be at least one more revision of this set,
but would appreciate feedback on this version of the Documentation
update with respect to preservation of existing interface names,
explaining the changes, and deprecation.

-- 
Jarod Wilson
jarod@redhat.com

