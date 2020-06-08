Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89E1F1F9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFHTPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:15:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33997 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgFHTPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:15:49 -0400
Received: by mail-il1-f195.google.com with SMTP id v11so17944539ilh.1;
        Mon, 08 Jun 2020 12:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVsoFmj/HOOaF4AtOKuEbVSeUbWa/HT5CaZGq3xuk+k=;
        b=SidH17wIWv+MHoeSVtnM0+dASgeqKpWg4hEID5P2eVIn3Ij97EFlCt1zNauiGPGGUz
         8RHdhY44VkOUvedpqROmJXTh5KWOdc1zeXV5igI6nYvUkAO6gZAJDohFNEzZ4g5uTGJA
         RzF9jKK+4tzl3QtbwVuik4jaRFY9aHY9fiuFxBReXb38rumM1qrVVWOibTdNh9+iSJMe
         G43Vo/DMG44+g76nLnp/xS3rJ0sF5yWQvToXBHB3mLBzXGpHTgPmrp26SUCD/EXPj7g8
         qO8XnvVJwnfBERFOV0fNX4/zyyl18boiU0LuI91I5M+jLcFbOgYO+TrPMn/KKkSwyl4b
         QVnA==
X-Gm-Message-State: AOAM533y+11UkW0CHNZXNcGi4ElTjVYitg0UgU+bo1KfXrkmWNruYzGQ
        ozsxeBDTamXHK+qpLYtJpw==
X-Google-Smtp-Source: ABdhPJyyki13Kmz3IcORTgD+J9l61fT82bMJryDN6e0+3h6Bw9W1SsjOXqx6qWzG/BBB8aIs7YDvng==
X-Received: by 2002:a92:d905:: with SMTP id s5mr23653121iln.268.1591643747050;
        Mon, 08 Jun 2020 12:15:47 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y12sm8016889ili.83.2020.06.08.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 12:15:46 -0700 (PDT)
Received: (nullmailer pid 3350297 invoked by uid 1000);
        Mon, 08 Jun 2020 19:15:45 -0000
Date:   Mon, 8 Jun 2020 13:15:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] scripts/dtc: use pkg-config to include <yaml.h> in
 non-standard path
Message-ID: <20200608191545.GA3346390@bogus>
References: <20200505100319.741454-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505100319.741454-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 07:03:19PM +0900, Masahiro Yamada wrote:
> Commit 067c650c456e ("dtc: Use pkg-config to locate libyaml") added
> 'pkg-config --libs' to link libyaml installed in a non-standard
> location.
> 
> yamltree.c includes <yaml.h>, but that commit did not add the search
> path for <yaml.h>. If /usr/include/yaml.h does not exist, it fails to
> build. A user can explicitly pass HOSTCFLAGS to work around it, but
> the policy is not consistent.
> 
> There are two ways to deal with libraries in a non-default location.
> 
> [1] Use HOSTCFLAGS and HOSTLDFLAGS for additional search paths for
>     headers and libraries.
>     They are documented in Documentation/kbuild/kbuild.rst
> 
>     $ make HOSTCFLAGS='-I <prefix>/include' HOSTLDFLAGS='-L <prefix>/lib'
> 
> [2] Use pkg-config
> 
>     'pkg-config --cflags' for querying the header search path
>     'pkg-config --libs'   for querying the lib and its path
> 
> If we go with pkg-config, use [2] consistently. Do not mix up
> [1] and [2].
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/dtc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Sorry, missed this one. Now applied for 5.8.

Rob
