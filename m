Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0D2E05FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgLVGRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:17:13 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51732C0613D6;
        Mon, 21 Dec 2020 22:16:33 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 15so13755373oix.8;
        Mon, 21 Dec 2020 22:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GsJ9t2DQksVa84TtSFlyEhbEZGFOhW7YiKQ7R1UqKy8=;
        b=bHxHTKPRZbhOdCdGWAjyXLPdWWNJtJ3xlHnWeiegAPHf/DOSq2CKeoKhiGig3UYKSz
         t3+9AJq8ZK1VoAu8r5spoVYSE0JbK1T3j4h/Q3X5FiRKcLaNBo8pBo3sRXHH8FGldihw
         1IWAUSfSyJ54++5bVrgW9Fhs0jvGcwSvCTOVMI+1L7XHSgpyqvRa5FXsJWnP1SRsntS6
         6utXuVGbLV5CY+rydHvsLFer3WN/XDCLtK30ISGmLObYDlP8tJiCQkVbYe2o8/ORsc7W
         oCQqNyyY6QdHiAKiJSGQOw2TWBhZL9zzTp7yo284oDd3vpY4aoehZwkgoCDFh5EwilMx
         QXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GsJ9t2DQksVa84TtSFlyEhbEZGFOhW7YiKQ7R1UqKy8=;
        b=Dgs3RwK3ikyEkfLg+SkPWBcPgH83pQ3Hwcd/2Txa1iBFUa7RxhhgY8Z+XAz2d3m0T0
         GiVzjmNWgQRLGt7HU+h2tD3paKsQhtUqwtjlpsXwA/p62aP/XO8z1Kjjn/WYiOJT9fLm
         XzWh8KPpzqD8U+S+Rl2jm2E9qzx26SuixDU5HSh1Cj4TQufaTPsxRyNCfhrabwmjoUV/
         pZCve+LjhynKWpIIpV09P1a8Gl1Gab9EuwCyIWIIQJVuuWYChQwOgOj1BoOcjY9HPP+6
         rV3Wh4GiDiPA7muStf3UCwnTJcehSbaiX/I5RtgYxyxzOMVvUyg4ufks9VD00f8GIh7y
         yUOw==
X-Gm-Message-State: AOAM533BMhuCVd6oEiarGeJo+nxx0D2NUSSigrUof0YExfmVb3XWQKRk
        Gj7CE8MReXgoTkTuMG5RnUNWEljloDE=
X-Google-Smtp-Source: ABdhPJycVllZh0KDGzUfdrd7FjSu0ARgUDiD6w3Gzg+UGjD150HFquaX1LYcFY5C5ktqV//WX202Sw==
X-Received: by 2002:aca:af4d:: with SMTP id y74mr12893615oie.105.1608617792738;
        Mon, 21 Dec 2020 22:16:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f67sm4305127otb.60.2020.12.21.22.16.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 22:16:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Dec 2020 22:16:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
Subject: Re: k10temp: ZEN3 readings are broken
Message-ID: <20201222061630.GB76917@roeck-us.net>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
 <CAEJqkgjFVBEDxCVB+P3CjirRkCZW1_6s18AgOKpe+6er3VShpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgjFVBEDxCVB+P3CjirRkCZW1_6s18AgOKpe+6er3VShpA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 05:33:17AM +0100, Gabriel C wrote:
[ ... ]
> At least is what the weird amd_energy driver added and since is only supporting
> fam 17h model 0x31 which is TR 3000 & SP3 Rome, I guess fam 19h 0x1 is
> TR/SP3 ZEN3.

The limited model support is because people nowadays are not willing to
accept that reported values may not always be perfect ... and the reported
energy for non-server parts is known to be not always perfect. Kind of an
odd situation: If we support non-server parts, we have people complain
that values are not perfect. If we only support server parts, we have
people complain that only server parts are supported. For us, that is
a lose-lose situation. I used to think that is is better to report
_something_, but the (sometimes loud) complaints about lack of perfection
teached me a lesson. So now my reaction is to drop support if I get
complaints about lack of perfection.

Guenter
