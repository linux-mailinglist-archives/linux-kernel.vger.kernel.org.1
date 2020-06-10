Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1A1F5B17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgFJSXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 14:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFJSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:23:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1481C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:23:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so1254731pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eyo+7zh1L4jeDWREBakg6eAo0YMYPGwdx3QTIkC3cqE=;
        b=a5YWD529dgAdWo2ddTqn+wtR9NFsHDhDH9quAab1/Ts3LSpxdlSdxy6dn8UU0GmYJg
         mF2n+LTmi5kCWCRmW9o+w4lNEWGgoOk4zlw2My0hTdaZrNFXacyNCFGb3+7n4Ab2nC6N
         DusWKIIlMvWFsrA0CRBntWUVRbH7QMccO/RQD7cQ85pCqC8xtPC3uW01YHIYWtChIbIr
         MKkdZHznXgRBPNojpB8Jdq2lamuckQvYy0OBF/tMLdUqaQV+bhucitSwmnuYioDBWav7
         ZxeY74vjeQr250yLyShoxh4o49WZ/SkYC6Yp2etGuaMrgCe4BUV5Q+tC6+w5HUtpy8Qw
         QbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eyo+7zh1L4jeDWREBakg6eAo0YMYPGwdx3QTIkC3cqE=;
        b=Xo7XpuDT5UxhA4kVFs3rx+fl/ac5g9aPddktaq2XWbxiP9oMZLlWgW54J180JLHU+B
         ZoX1egp58Gi16wyDaduEmVYRj1CW5n7xw9hIW803/wTwc3XfXecNoqndMDN6sROOzdWg
         zEJk4ZDRvbfNfafmbU5iXITM1Z02PrluJXgy9ey0LWDWjAyZPpXqjIIBfIxS4JHPHo/b
         E7Bj3IVlEmEdkhJLoYr0CoBvkW1MBPiHIkuJC3ai4sTPQGmkdk89Gan4++5qpY1WpwOx
         awt6RtDIP83W4SqsFjMiOV4JXHC5jG27hPXbXj5OlU2zYoj5K1biWT+wPOSYP63VRoTK
         1rrw==
X-Gm-Message-State: AOAM530NK+GXK5aGre56OPePOPYMt7SRKpI0Q26ajpm9ARXxaKi0i6N2
        WErngThT+wafI2GP9eXPPYfW+0EThSEoTTfQ
X-Google-Smtp-Source: ABdhPJwlTj9PIl3lYfVxAKZJrGw9skNy0yB4QNbnAqbu5kbKDhGJt6xeQOyHbSMwPeJUry2pOcPQXQ==
X-Received: by 2002:a17:90b:e8f:: with SMTP id fv15mr4538238pjb.47.1591813411940;
        Wed, 10 Jun 2020 11:23:31 -0700 (PDT)
Received: from gmail.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id 140sm577886pfv.38.2020.06.10.11.23.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:23:31 -0700 (PDT)
Date:   Wed, 10 Jun 2020 23:53:24 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200610182322.GC21465@gmail.com>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610173711.GK5005@sirena.org.uk>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:37:11PM +0100, Mark Brown wrote:
> On Wed, Jun 10, 2020 at 10:58:24PM +0530, Vaibhav Agarwal wrote:
> > The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
> > During the development stage, this dependency was configured due to
> > various changes involved in MSM Audio driver to enable addtional codec
> > card and some of the changes proposed in mainline ASoC framework.
> 
> I'm not sure why you're copying me on a staging driver?  I don't recall
> the base driver having been submitted properly yet.

Hi Mark,

With patch#6 in this series, I'm proposing some of the (dummy) helper 
APIs required to link DAPM DAI widgets for the GB Audio modules 
added/removed dynamically.

Eventually, I would like to propose relevant changes in snd-soc APIs to 
enable dynamic linking of DAI widgets for the modules added and 
remove/free component controls for the module removed.

I'm seeking your opinion on the proposed changes. And as per the 
recommendation I'm sharing the changes with ASoC mailing list as well.

Kindly suggest me the preferred way to follow on this thread. 

--
Regards,
Vaibhav
