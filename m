Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE42260D79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIHIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 04:22:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729813AbgIHIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599553331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpXz+q9ud+AOPvV34hwZq6iLp3ZbJEEfJ7EHtLY6RqI=;
        b=LIyKGKDT/8npeWzLh4N6YG/2UE82V17YNKI9tAHQfVkqEnZ/8ktwnb39GIBJdAPVVVjN4C
        hlImIISNYcLP9qebUe8zjL5oc+fFr1EMkCP+r0b5cJBJjRzGkSf+G5Kl1nHHJb7lE8BVkw
        36yojQWKc+eF+8cty28aVXVZ/oJm8po=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364--oi7rAA4Pu2IGLyHB_ZeGA-1; Tue, 08 Sep 2020 04:22:09 -0400
X-MC-Unique: -oi7rAA4Pu2IGLyHB_ZeGA-1
Received: by mail-ej1-f72.google.com with SMTP id b23so6412618ejv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wpXz+q9ud+AOPvV34hwZq6iLp3ZbJEEfJ7EHtLY6RqI=;
        b=ZlXQ7sVqz1yxemzhDD+tkqYl04mvwoE+xQpptNgwaeLpvyLVpjDK25cmR1FrTFjCIa
         F20P7ZZVM812sfTBpbihaFzLYoO6dEtkksJGIGxmnnKv9pVMFUoRLNPN50ueC5yI2W4Z
         4c69SKXBGbdplJ0MD0tbODPlRtvkHBTSrTjHXLWHubkg0aKFc5JA6UT0nAkPhS8S+Qtz
         lQOLaWpJ3qbFP3Pq27/byqrY60P35ok5oWJL0AvB1mq1F/qUBcWunO29y1F022zG4DlR
         a9BTl+hTKB2OzTAPOqjyWoDrCfagQqbrVVP+xDDdjm5VIJya1pNBeiAREtj6tmlvV+QM
         x0LQ==
X-Gm-Message-State: AOAM532D29qGgRK0zXuRrjRD5UKQAHJ4Q/72GeOPT65DBVeT+monU7tv
        PolkjpbOpB6jXAHOHA81k9/i7Swfi4Ja7fzz7p9+4Bn1d9+6gsOPWmvs2TtZ2ZllURD1Z6xJXB6
        p5jgqlhS8YozGMLV9uMiGVZxw
X-Received: by 2002:a17:906:6a50:: with SMTP id n16mr437640ejs.107.1599553328055;
        Tue, 08 Sep 2020 01:22:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSpUnMjZKtgUsJ+BcSD0zVfJfVDHsM/AFxTEzrhyw0d1WYhP2BgF9hcfPBn3/2GC9nlSOMMQ==
X-Received: by 2002:a17:906:6a50:: with SMTP id n16mr437624ejs.107.1599553327903;
        Tue, 08 Sep 2020 01:22:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i7sm7632087ejo.22.2020.09.08.01.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 01:22:07 -0700 (PDT)
Subject: Re: linux-next: manual merge of the drm-intel tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Guru Das Srinagesh <gurus@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200908140022.67dd3801@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db369f50-a3a0-2504-0628-ce5e6780d31b@redhat.com>
Date:   Tue, 8 Sep 2020 10:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908140022.67dd3801@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 9/8/20 6:00 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-intel tree got a conflict in:
> 
>    drivers/gpu/drm/i915/display/intel_panel.c
> 
> between commit:
> 
>    f8bd54d21904 ("drm/i915: panel: Use atomic PWM API for devs with an external PWM controller")
> 
> from Linus' tree and commit:
> 
>    6b51e7d23aa8 ("drm/i915: panel: Honor the VBT PWM frequency for devs with an external PWM controller")

That doesn't sound correct, those are both commits from the drm-intel tree.

> from the drm-intel tree.
> 
> I fixed it up (I just used the latter)

Just taking the drivers/gpu/drm/i915/display/intel_panel.c contents of:

f8bd54d21904 ("drm/i915: panel: Use atomic PWM API for devs with an external PWM controller")

Is the right thing to do, the problem is a difference in a line which gets
removed in that commit.

Regards,

Hans

