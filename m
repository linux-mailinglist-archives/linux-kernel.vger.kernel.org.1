Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E281B181E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 23:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgDTVNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 17:13:52 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:44620 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:13:52 -0400
Received: by mail-oo1-f66.google.com with SMTP id p67so2454899ooa.11;
        Mon, 20 Apr 2020 14:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEOjjjtQz9Vnq1KP3e3xrBz5qWH4d/8MKyIiQy0K/uA=;
        b=R32Hq9otd2L+OtbB7vFobc50tosyqj4UX8fzJWdjCU/bQ08kSrDG3riw8LawkWzVSi
         L/oFYswwINBkWix1TMEsDMHVx3GNXY3p2BN/ROkIejLS0zCtLUxhemEt7nuxgBrqeQhv
         NRxyL918wqU4z6MU6MhtyOBVfiBLIEKKk7bCTm1RUZwMAMXa/Jtr7PkeB9jFpqDTS5FK
         Sy1hIiCphvYZ0K9f+FEX7qpU5rz7AepaWDHMyWiOPUPCwPymgBNQrXrMY1WJ/WsLeaW5
         VUWqSrWFp4N1v6aYc85NdrELFi3pYdGPdsNaJYw/hHKX5VSrphigBaCpXNDApyZOEhD2
         xZtg==
X-Gm-Message-State: AGi0Pub515rCnjVURfm9mgn2+5/Oq8l2+dfnoafULDQ48VOcRTz4Z/Yb
        pPC6aPKVnqofOqBZ1HZhpA==
X-Google-Smtp-Source: APiQypJd+FO1fX6clVbxSEcDj4px4F3lcYXlRdPj7fldtoMnAg+jYmcsMFVHImnx6rOTzcOD8MIOnA==
X-Received: by 2002:a05:6820:221:: with SMTP id j1mr14553878oob.12.1587417231315;
        Mon, 20 Apr 2020 14:13:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm216861ots.29.2020.04.20.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:13:50 -0700 (PDT)
Received: (nullmailer pid 14172 invoked by uid 1000);
        Mon, 20 Apr 2020 21:13:49 -0000
Date:   Mon, 20 Apr 2020 16:13:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        charles.stevens@logicpd.com, Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt: Add additional option bindings for IDT VersaClock
Message-ID: <20200420211349.GA14073@bogus>
References: <20200414193616.1368209-1-aford173@gmail.com>
 <20200414193616.1368209-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414193616.1368209-3-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 14:36:16 -0500, Adam Ford wrote:
> The VersaClock driver now supports some additional bindings to support
> child nodes which can configure optional settings like mode, voltage
> and slew.
> 
> This patch updates the binding document to describe what is available
> in the driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>
