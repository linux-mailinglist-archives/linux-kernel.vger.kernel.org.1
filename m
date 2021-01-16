Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6676C2F8D48
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbhAPMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAPMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:23:32 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B33C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:22:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b26so17213554lff.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VZQgXJ3sozKQS+EOLjQhPRf8+tiITg33CWg9Ya6+elE=;
        b=U15IpH/80IkVMuRVSTT+D0VqtAzhnCWcvJAoz99h0HDGz1vGpfRdtbEYL6h314gFpA
         qnELWLtY7TZTqwHHB62CCnDscY/7nJ/e6V5uFYWEMZ0oazQrhXBmZNOV+OpCkNyjOhdf
         myUMlzmpmPxEQ/LrASWVx4mTLlSvdL41zNRWQ0Ymxm6T/Nl8FBtMsGrFad3dyJWT1oV3
         ApSIx00WDfK1lYw1/5R3nooLT/X1jtVtNES+yccSBl3tWbhEKmmodnbi9PDWGetSsJCz
         LIsSSKq10FBFxy9G/eqLqlY+C2mQ5ooMANxTLs0xkH5hm0fNt9guDE6noTcfcezmsDw0
         E2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VZQgXJ3sozKQS+EOLjQhPRf8+tiITg33CWg9Ya6+elE=;
        b=EdHIx3zX8JXOrO1quNcwmbC5eeL0xHzdYbvMBh5IJ4MMcaXVYf1C4tMofUC7Jnwb/P
         +cQ4eK5fq3dBmB0d49eKo+nE46Cmf79J1h6hBvuz5g/Jf2qRCKSSdYg1XQ+plae4kXj3
         42gyaDMFURTZIaicpeKLiy4cK81UFQxDg+zPQBb7zhgIcRm3UsuBzrTaF9P88Oz3Rvlt
         zFJyrIBFjs8fZPNIW0TBjxKHC4fZ5BhcX1ojYR4HSOHyLPO7mZELr3B3M2CGyVNaheIP
         fUFUU78p5c/9Lm9oyOvjE434fqmXRcmsIpMkyAR6JQ0Z40bmksU3WTAZ3qM446+O9I1v
         rUKQ==
X-Gm-Message-State: AOAM531abhP4jXLOlcLDy0osrWedH8iyd6NMfelSywUU1KDKxmIMVz6I
        ZPLISqbB9drH/Nrlfkv5hEYAySRYk2FQLvIW
X-Google-Smtp-Source: ABdhPJwv8yd2BfxvPK6uYIqrG/oujdKSdPPU+zoPhi+sLcdwy9JZFT/bcOkxu3d9QE+YTmHKCTL7gg==
X-Received: by 2002:a19:3806:: with SMTP id f6mr8206820lfa.242.1610799770651;
        Sat, 16 Jan 2021 04:22:50 -0800 (PST)
Received: from wkz-x280 (h-236-82.A259.priv.bahnhof.se. [98.128.236.82])
        by smtp.gmail.com with ESMTPSA id n20sm1252416lfh.133.2021.01.16.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 04:22:50 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: use mv88e6185_g1_vtu_getnext() for the 6250
In-Reply-To: <20210116023937.6225-3-rasmus.villemoes@prevas.dk>
References: <20210116023937.6225-1-rasmus.villemoes@prevas.dk> <20210116023937.6225-3-rasmus.villemoes@prevas.dk>
Date:   Sat, 16 Jan 2021 13:22:49 +0100
Message-ID: <878s8tkr52.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 03:39, Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> mv88e6250_g1_vtu_getnext is almost identical to
> mv88e6185_g1_vtu_getnext, except for the 6250 only having 64 databases
> instead of 256. We can reduce code duplication by simply masking off
> the extra two garbage bits when assembling the fid from VTU op [3:0]
> and [11:8].
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

We might also want to give mv88e6250_g1_vtu_loadpurge the same
treatment.

Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
Tested-by: Tobias Waldekranz <tobias@waldekranz.com>
