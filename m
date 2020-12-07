Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF42D1D97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgLGWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:42:16 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878BC061749;
        Mon,  7 Dec 2020 14:41:36 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id d17so21845270ejy.9;
        Mon, 07 Dec 2020 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLc/SHjSNl6PUkflh89RJh4GKASpYHLMHjFPMsm7Ir4=;
        b=oLNPdAyktN/AyJU9ucNs0RUmdRsTYHODuIKyDjrn+eB5MJk2V85yso+j5/Z5d2VMSk
         JcKjxzBQ3TAThYirpQ6fAeHv0O8FlkTr8+je3NIIAkd3Z6TEJ2utdJWHHxNnw+f85V9a
         nzesyoR34EatevttyoCnh1KxenHYaSZVvKrXSORuSwU5gmaeXbmx044kLEAdhWcX3hTn
         5ooGtSChEMcB/TIG75q3s1iuClVZqydQogf7+qQx+zBg/3DcKFYHdAlXezRG+gU7Yryk
         0ta4c9OdNmNaB8YCJLRD8XSG78MuK8rTgoq0QX98QlSexBFajlkU7I2wziF3D2eei+oo
         YqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLc/SHjSNl6PUkflh89RJh4GKASpYHLMHjFPMsm7Ir4=;
        b=BJnyGt0SDuV5hiklOD1XAZsDXj6MVvY7I3EC8SCHvCBB3QbdQpuOSUugq0gohWoudf
         n5JChOf/+BY+9bwVC3tkVacqYDuy5UgnJWwN/AwUDWOeFK3zAPMSIfMw9kfSJD4n9eZa
         fvwvC32szEnKrhIqJYTFIxnWE8x3nFcfS0GzKtd54IGX0aE4gi4+n+0fiGpSFeWoKtkm
         15nkNU4sF4bEP5dM6yB14oiAjtHmL0AsRyTFIyPBWqmc5rf36tiPj5c7DIL+9iI9+dfZ
         R/HKIhgzxXtWSAvVWMmIFrL2uMiUMa6OxNkSwd5iSHkCanPRWayxOXmYj/UTKT5JenFD
         UXyg==
X-Gm-Message-State: AOAM5332z07bF3jd+WVbqDGfFdvVatkYO0UDPFtwIcrUUW0yAXFF57GP
        TnPE8RxZU1FSCytEKASaHto=
X-Google-Smtp-Source: ABdhPJxal3rSx9a6EBkQv1k36LBnhXorShuXZdFJqSyschKJf+sUHwOzPeQ1TSdJZuh4toPHDz0e3w==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr21048772eju.305.1607380894694;
        Mon, 07 Dec 2020 14:41:34 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id c25sm13994082ejx.39.2020.12.07.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:41:33 -0800 (PST)
Date:   Tue, 8 Dec 2020 00:41:37 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: Fix error in 'make dtbs_check' when
 using DT_SCHEMA_FILES
Message-ID: <20201207224137.GA250758@ubuntu2004>
References: <2519b8bde507ca6ccea9765ea197adaaa69a66d5.1605712328.git.cristian.ciocaltea@gmail.com>
 <20201207214831.GA865971@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207214831.GA865971@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:48:31PM -0600, Rob Herring wrote:
> On Wed, Nov 18, 2020 at 05:20:50PM +0200, Cristian Ciocaltea wrote:
> > If DT_SCHEMA_FILES is specified and contains more than one file paths,
> 
> If that worked before, it was by chance. :) Yes, it's called '_FILES', 
> but more than one was on my todo list.

I've been using it for a while, but I didn't know this was not
officially supported..

> Anyways, I'll apply it.

Great, thanks!

> > 'make dtbs_check' fails with the following message:
> > 
> >   $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   Documentation/devicetree/bindings/Makefile:77: recipe for target 'Documentation/devicetree/bindings/processed-schema.json' failed
> >   make[1]: *** [Documentation/devicetree/bindings/processed-schema.json] Error 255
> >   make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.json'
> >   Makefile:1364: recipe for target 'dt_binding_check' failed
> >   make: *** [dt_binding_check] Error 2
> > 
> > The error code 255 is returned by 'dt-mk-schema' when invoked as
> > 'dt-mk-schema -j -u @<tmp-file>', where '<tmp-file>' is a temporary
> > file that is generated to contain a list of SPACE delimited schema
> > file paths, as indicated via DT_SCHEMA_FILES.
> > 
> > However, it seems the file format has been recently changed in
> > 'dt-mk-schema', which now expects each schema path to be provided on
> > a separate line:
> > 
> >  $ dt-mk-schema --version
> >  2020.12.dev4+g6de1c45
> > 
> > Therefore, let's change '<tmp-file>' content format from
> > 
> >  path/to/schema1.yaml path/to/schema2.yaml ... path/to/schemaN.yaml
> > 
> > to
> > 
> >  path/to/schema1.yaml
> >  path/to/schema2.yaml
> >  ...
> >  path/to/schemaN.yaml
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> > index f50420099a55..643eb873fd51 100644
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -37,7 +37,7 @@ quiet_cmd_chk_bindings = CHKDT   $@
> >  quiet_cmd_mk_schema = SCHEMA  $@
> >        cmd_mk_schema = f=$$(mktemp) ; \
> >                        $(if $(DT_MK_SCHEMA_FLAGS), \
> > -                           echo $(real-prereqs), \
> > +                           printf '%s\n' $(real-prereqs), \
> >                             $(find_cmd)) > $$f ; \
> >                        $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
> >  		      rm -f $$f
> > -- 
> > 2.29.2
> > 
