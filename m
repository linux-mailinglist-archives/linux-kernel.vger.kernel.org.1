Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF22545EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgH0N3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 09:29:55 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41219 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgH0NUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:20:21 -0400
Received: by mail-ej1-f65.google.com with SMTP id b17so7606537ejq.8;
        Thu, 27 Aug 2020 06:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+KqXoKi8jzmcX+Sa9PiCc9RKtqp2ZYsWQ4PPSxBca0=;
        b=TKkFSj5YDXyDVPyOwbDMHWXv6dxo4ZN5sZJu1id0iJqhZknVkgsq+oS5tHo9wJp02c
         ksuloFF6vb4NqYWDrnnZVyKmirLaK4a3Qb5RhcNkV1/a9EmPkY8yHqOf0tYV3o/asnK7
         x6Rs2HKhYkFZGsbvY3rwiBYJzKme7xucN2mimswuJLvEyHNdgeLnNZO6JSbLMCRnBAh8
         WiTDF3c1V/5YsRAch0THA4VoWa5woLBWhiCqk9DJUKZr8f+nW6chntnNXB27xKUIW9QS
         7mVb5X2ZkopFFUpd2p7URFgGhmplCL8dTW5XqXxLtB5GHzHj8glGm5d1qkbGqjQInrTJ
         eyJA==
X-Gm-Message-State: AOAM530Ddcr44acDj+atUuL0bRZMQBE4OisbmsH+mWUTITquF5dS+Lz3
        qP+olvyGcskElOA7sAUpE/E=
X-Google-Smtp-Source: ABdhPJxPyw+OJB1aU+cC1IAmQc4RN+hp++iPrN/DqEjJmUPSL4qvfu4VUa27lZCy7xAoFrk/ffMtHg==
X-Received: by 2002:a17:906:dbd2:: with SMTP id yc18mr22000122ejb.394.1598534418938;
        Thu, 27 Aug 2020 06:20:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id w23sm1520480edr.24.2020.08.27.06.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 06:20:18 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:20:16 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Security Officers <security@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add security docs to SECURITY CONTACT
Message-ID: <20200827132016.GA4384@kozik-lap>
References: <20200827131330.3732-1-krzk@kernel.org>
 <20200827131827.GA546898@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827131827.GA546898@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:18:27PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 27, 2020 at 03:13:30PM +0200, Krzysztof Kozlowski wrote:
> > When changing the documents related to kernel security workflow, notify
> > the security mailing list as its concerned by this.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8107b3d5d6df..a1e07d0f3205 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15620,6 +15620,8 @@ F:	include/uapi/linux/sed*
> >  
> >  SECURITY CONTACT
> >  M:	Security Officers <security@kernel.org>
> > +F:	Documentation/admin-guide/security-bugs.rst
> > +F:	Documentation/process/embargoed-hardware-issues.rst
> 
> The hardware-issues document is "owned" by a different group of
> suckers^Wdevelopers, that is independant of security@k.o, so that file
> shouldn't be added to them here.

True, but isn't this broader security group involved in designing and
discussing the HW security process?

Best regards,
Krzysztof

