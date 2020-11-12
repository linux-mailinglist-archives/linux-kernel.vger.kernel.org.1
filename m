Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A22B0B53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKLReE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgKLReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605202442;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNWEthHOidlhufNCdnp2GPCUCBNGyMdhd/Ck3gzrwvE=;
        b=C7GMchLD7Ie98ekRlelUVjVXKzcRvEvbgad/UnJ5cfNpoAgBLpjwtu8vRjrAVoU+kZgDkx
        z5NxbP+mIR4AxWb+EA9k+eiE5CyNMa4fk/BiUaYpmL7YYoSC+96By8XrNyQwknCCWWQ7we
        CpJdTcwjUdSh/2BNtSvcHI5RBG5jYiA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-JhdVbaftNYqmd21JVURXSA-1; Thu, 12 Nov 2020 12:34:00 -0500
X-MC-Unique: JhdVbaftNYqmd21JVURXSA-1
Received: by mail-qv1-f72.google.com with SMTP id ca17so4300636qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=fNWEthHOidlhufNCdnp2GPCUCBNGyMdhd/Ck3gzrwvE=;
        b=fVdJkRNIQz/cTc3Wcs/cbwQ8BxbMhpcHgLh/j8y1PPQ9juBUxCc6WMx299I5pZVcpX
         gbiokvPoBJsiAjYbCQK+Qwghign+hZWDFiEFq+V510kc3eFk/If55dcAxE1NNaw896cA
         kCwVb3llKEzmG3Womis6LWkCMpOLTwZj233whcAmj0qh9YwKZxYkP9U2iQt+WJ5AvCZI
         KV+9EsoUaNybvRfGuox4x6p1b9Bu/G6lJpNugfV/sGrSUsjP8at9PJumHL9yATtr8hNE
         HMEaYKHiRAs2uP9h46yqO35AxxYIZhHdNsDVSWmHAF8gzy8Tm6QxF2GPb/LOgmBRKDSF
         gcfQ==
X-Gm-Message-State: AOAM533LmjbVT6S1YG8bZK5SdCmyTpjsm1MUaNB7wybV3Y/WOH2wXC4n
        pgvt61KJWi8TM95znuMwLQFFAnuJfQFw4p4hDQ2tJxACURhypvbkWS+mczEw3w9MZr+XoE8FfYb
        lLiGUnIKS8l2CGno/3HjNRTy7
X-Received: by 2002:a37:8984:: with SMTP id l126mr802705qkd.443.1605202440279;
        Thu, 12 Nov 2020 09:34:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQueDJ/fnB0wjuH067y3CSLg64P1iPswuGiPavMfFJ1UUfqc62ygP8n5sqSZVesQptMM+CQw==
X-Received: by 2002:a37:8984:: with SMTP id l126mr802688qkd.443.1605202440099;
        Thu, 12 Nov 2020 09:34:00 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f56sm5426315qta.49.2020.11.12.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:33:58 -0800 (PST)
Message-ID: <12ea721b350b9bd2a361ca2fd3ad0db79d37107a.camel@redhat.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Thu, 12 Nov 2020 12:33:57 -0500
In-Reply-To: <20201109115209.rwhoe4zttaxirx6c@box>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
         <20201103222013.hypmzlq7uuqufe76@box>
         <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
         <20201109115209.rwhoe4zttaxirx6c@box>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI-looking at this today

On Mon, 2020-11-09 at 14:52 +0300, Kirill A. Shutemov wrote:
> On Wed, Nov 04, 2020 at 04:58:14PM -0500, Lyude Paul wrote:
> > ACK, I will send out a patch for this asap
> 
> Any update. AFAICS, v5.10-rc3 is still buggy.
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

