Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDE2D2017
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgLHB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLHB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:28:59 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA871C061749;
        Mon,  7 Dec 2020 17:28:17 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v3so6095833plz.13;
        Mon, 07 Dec 2020 17:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g6R21sa3bkOjEnwqhAVxyM+kWVKk9KN5CJ8WQiyRzKg=;
        b=c+bi86iXy/pSBac/0D9EHuYLqSgzndqvSEaxFibcNpweMKyQygRkZzQDEMO+Qw0UxT
         /33sCLHGIDMYobzNYwvDSi74tyY8ITvbbDU0Sk258GTxreVez+owDIlHjtcFzsZa3xix
         ndvhJ1d6ZErYf3EfuNA0LAXY706OqaLr54H27c48TPfhCf0qaS4L6PqOmMCtN1HN3dO1
         QEJZ6vbRb6gjEs93MG4zMFETc25vJntRNgVRpY1n02Py/AK4BmQHWQK+H8sSTwpOHpWn
         XXq5k8unAN/YWq7bTwYRW4BFivBs+VzBJ60omZmbh14WbOjmjjO7/mdsrXwe3+w0Qdr2
         OW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g6R21sa3bkOjEnwqhAVxyM+kWVKk9KN5CJ8WQiyRzKg=;
        b=FtNouGG++ajaGcmkXtV6uQMuw3t0t1OnxLxOp0Gx9kPAmYjfZ8Im9dnc7+Bd0KgF9R
         cLi1FmelndDMsjWnnHJBh3BW1WzuFhlBbf5S5I+yTbPdgAyMkVXz317dC5Ry1ydI3txt
         X/t1OkPbtzna1dCHuW8uvXncX7cPwz52fym1Tv+5vmqlMySluCSRKgY++JFcDP0ZN3+Y
         dXxw220srwWFMjbYIeS1BbtVRwT/89ZKaZksSouuYGdu24qOcZYQc+5EqrToAzoz/XQ7
         EmDRYGubfJcDOBunp8pxM0St85X2W3zLHUpYcJy7PRstdYBUOai7C4KkGPM1ukgJMe9h
         AK2Q==
X-Gm-Message-State: AOAM532oLQqZA7JEDiaEI3eP4cncbN0L8Txw1BgfoSI3jTx6XhYjq8zN
        DXQbxItG1QyX70Cvd/+rWWwp9CiTHUpHMw==
X-Google-Smtp-Source: ABdhPJxpxLxNICfqOJ5BiNFYHNzVKl0q1JwFffvvXbpF0tW9FuLkpPPBA+bELyA/XOq2JtoKBTRo5w==
X-Received: by 2002:a17:902:6ac8:b029:da:d645:ab58 with SMTP id i8-20020a1709026ac8b02900dad645ab58mr16864544plt.25.1607390896709;
        Mon, 07 Dec 2020 17:28:16 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a22sm12495382pfa.215.2020.12.07.17.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Dec 2020 17:28:16 -0800 (PST)
Date:   Mon, 7 Dec 2020 17:25:26 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: fsl: Add imx-hdmi machine driver
Message-ID: <20201208012526.GA21510@Asurada-Nvidia>
References: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
 <1607251319-5821-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607251319-5821-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 06:41:59PM +0800, Shengjiu Wang wrote:
> The driver is initially designed for sound card using HDMI
> interface on i.MX platform. There is internal HDMI IP or
> external HDMI modules connect with SAI or AUD2HTX interface.
> It supports both transmitter and receiver devices.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
