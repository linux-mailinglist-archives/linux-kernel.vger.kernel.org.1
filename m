Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9796D1A88FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503729AbgDNSPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 14:15:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33284 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503715AbgDNSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:15:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id m14so11278769oic.0;
        Tue, 14 Apr 2020 11:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bhkTVVrUOWVaLgCOuelNNGDtyH1myTqju9jYNZEaSms=;
        b=KlL+Jk+mY13wty9l9Fin0cUXTFeOWfnOD/z1s9bc7sb/OZc7wpl52Me6451WWT7QjH
         GpYxSjjUluMGyXon17rz4BjC8wZlZThxxCbLEzt6BL3ksX8bgiVOunsQGmSzNSQIUD0V
         jnkMvpo/jXPaTZky971AwqfkyeqlW+3S7T++TCvNQ6KcJYYQgdW12O4ZmEcmqvuPOjk+
         UaEAoDhdL9iQIVJF6DgChDiljorRlqIsZ+eG5HRQLfXhJbwGaOo1NIK5tNoJV5nFe7os
         rkLJ5esSgU0VKJ54BBukT4uBWY/A12h1TaiECiIn7T17BcrilnjWVrZ4Yp87smL32idi
         uWUQ==
X-Gm-Message-State: AGi0PuaF7+knPqHqwWoXUIuRibg8ZBCLQEI8FzviCgUpmzQyYpxGEzwV
        kEoIH/3zBsknEkuXuY6FnA==
X-Google-Smtp-Source: APiQypJhz+Cij10iNw4FM5iI4HyAhmq6Qeb2dhBZcO5cUhK6At8Krdfh0s0agGUa9KTaJkteGaSzQQ==
X-Received: by 2002:aca:3302:: with SMTP id z2mr16715406oiz.3.1586888141956;
        Tue, 14 Apr 2020 11:15:41 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z24sm1519586otq.75.2020.04.14.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:15:41 -0700 (PDT)
Received: (nullmailer pid 20117 invoked by uid 1000);
        Tue, 14 Apr 2020 18:15:40 -0000
Date:   Tue, 14 Apr 2020 13:15:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        charles.stevens@logicpd.com, Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt: Add bindings for IDT VersaClock 5P49V5925
Message-ID: <20200414181540.GA20033@bogus>
References: <20200404161537.2312297-1-aford173@gmail.com>
 <20200404161537.2312297-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404161537.2312297-2-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Apr 2020 11:15:36 -0500, Adam Ford wrote:
> IDT VersaClock 5 5P49V6965 has 5 clock outputs, 4 fractional dividers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
