Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9C27E965
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgI3NVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728043AbgI3NVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:21:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601472110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIUeHCg4ObFBTzNeRmXqLyzNztGL/qF7cJVPSEqtDtU=;
        b=byiU3M1tkIjBHeKAUZJGWmP3HTnOcOgK24YPk8X5uIH+UuAsBZO2A3JbKGYXquxa7cFx/j
        0Mqx08p3i+CCrtvSGMqylJhJy6McReWwkW6WcV+qVjYJyHGORFUvhSnk0ReTCQDC0Ep+A/
        LZf8EU8RLjaXNX2h8WPxLa1Xf9KAgKE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-sES7WKoxPCSZvJYb3vy4Mg-1; Wed, 30 Sep 2020 09:21:36 -0400
X-MC-Unique: sES7WKoxPCSZvJYb3vy4Mg-1
Received: by mail-ej1-f70.google.com with SMTP id fx20so784688ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIUeHCg4ObFBTzNeRmXqLyzNztGL/qF7cJVPSEqtDtU=;
        b=G7qbxXlToHgP2PzsC7yquQiAPuft7RDJp12VpvVz8/8Xi7WV8aIUTkdl1vTBLesl4j
         BFIO4MgFQKWBHOBcYOyXuc5wBIGRPB/IZOozg55HWmbc49rccNPjRnlXKZdVx+JhbJWd
         G5J/2IvQVO2FIE6CD6FU/OP166tTpcJDCM3lcSGipMcuv8AZqNyUK11G3Zn9He9p4cAX
         s0wknI6RRyNhyI2i3bOKi/Wq30FAOSsw3I31WYDrLEYFyaa6oeXPVSzQjhCGfLXPGKTt
         rnZxNKyC2DJ+9DKO33fiyNAV/N+G6W3wPdUH/LJINqBmFy0kJNtgRs9Wg8yDECVdHTXT
         v7Rg==
X-Gm-Message-State: AOAM531LlsSk9hosJcXWRAhf6UWBI72NFdk6i6DedVGgFj/uEfV0uPwO
        iMeItIer+i6Tvuz1TkxwQ3bXiY782NEAEQIukeNs6vZ478AXwI1I6YPWZFhSapKlkGhV5rGf0at
        6h+QCWTpIuSL6bJCPgw7IS+fB
X-Received: by 2002:aa7:dd8b:: with SMTP id g11mr2815978edv.22.1601472095187;
        Wed, 30 Sep 2020 06:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjRXkc8KBbOEOGz8SxExRE6aSQo9uAeQL3oWdLMwX4Wo5s+uQYagR6+9+vpGbprIDRMHi11A==
X-Received: by 2002:aa7:dd8b:: with SMTP id g11mr2815953edv.22.1601472094956;
        Wed, 30 Sep 2020 06:21:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u18sm1580441ejm.115.2020.09.30.06.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 06:21:34 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5hft71klxl.wl-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <af0c9e79-c76a-8606-5811-702c791fa9ce@redhat.com>
Date:   Wed, 30 Sep 2020 15:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hft71klxl.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 10:48 AM, Takashi Iwai wrote:
> Hi Hans,
> 
> it seems that the recent update of intel-vtn broke the keyboard input
> on some laptops with libinput:
>    https://bugzilla.opensuse.org/show_bug.cgi?id=1175599
> 
> Blacklisting intel-vtn fixes the issue, so it's likely the falsely
> reported tablet mode switch that leads libinput misbehaving.  The
> affected machines are Acer E5-511 and ASUS X756UX laptops, and they
> shouldn't have the tablet mode at all, AFAIK.
> 
> Could you take a look?  I guess it's the commit cfae58ed681c that
> broke.  The chassis type is Notebook on those, and this type should be
> excluded as well as Laptop.
> 
> The dmidecode outputs and other info are found in the bugzilla above:
>    https://bugzilla.opensuse.org/attachment.cgi?id=841999
>    https://bugzilla.opensuse.org/attachment.cgi?id=842039
> 
> The one for ASUS is embedded in hwinfo outpt:
>    https://bugzilla.opensuse.org/attachment.cgi?id=841157

Ok, you should have just received a patch fixing this, sorry
that creating it took a bit longer then I had hoped.

Andy, can you drop the:

"platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360"

Patch from your review-andy branch, plug in the new one and
then send it out to Linus for merging into 5.9 please ?

Regards,

Hans

