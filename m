Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7415B2A7AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKEJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:39:29 -0500
Received: from smtp1.axis.com ([195.60.68.17]:19129 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgKEJj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2502; q=dns/txt; s=axis-central1;
  t=1604569168; x=1636105168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSvvC/bGSx+YFPB9J4IP3fSFAJxSJxXYvlKXo9Oj/zY=;
  b=pd687Ie1jZ8ZXpX1dFNhif7UPNfUoOjXInM3h6ZIYb1CUzPqW0Ogz/cE
   W7VBiDFZfbxmZaGO+BmauzD4AkVvZkD4O7dRxtAV71gFwIEZjePGAcQKb
   e746z6wH+YeQODe1AzTAPCOoYlQNsWWbpo25lGf248jYR579Fk7K9ArFs
   URYDuEMcMAoNVBvZRFESjkgKgx4ix3MyQ+oaNdbFTlNdzwSvleA51Ch42
   anM1TUrgqD0Y0HdPziOurLY0YjwglMf9Z2Q0DxkTgykQ0Nu82twMdWEfD
   QYA7+RjDgKWFxAdNTiM81FZ7Mc/5ci8VfvSiPUdKVHzdgx1vOZX0JxldD
   A==;
IronPort-SDR: lqb3Jeep7wHhHB6IlB06W+65EILSZ7xAypJ75jEygN5Z5JkKU6TM7dzpbNlcEPaDhldBR29CEL
 p20z0uB1CZ81PMhzpOuTQMV/+hNZtUsC2wzAiuUsxJBmaPuZslyaBIUrrgxJUZ151dYI3f3U49
 CBtiTJA+B2zUTdaq/O9N0m9q6wxGNAEzrRI45S2MLjaGQZE7pRt5QdNuha7qn7LRsjxuJyRNvp
 tSl9car+/wj1MC3HOM2rXN8Rr7kfXOtHOJQAg+qGJdhPZOLcYtqeWcgin2CnsH9+aRlmP4FwrB
 7jM=
X-IronPort-AV: E=Sophos;i="5.77,453,1596492000"; 
   d="scan'208";a="14760859"
Date:   Thu, 5 Nov 2020 10:39:26 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add DA9121
Message-ID: <20201105093926.msls7vgl42z7cpjy@axis.com>
References: <20201103100021.19603-1-vincent.whitchurch@axis.com>
 <20201103100021.19603-2-vincent.whitchurch@axis.com>
 <20201104185755.GA3948381@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201104185755.GA3948381@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:57:55PM +0100, Rob Herring wrote:
> On Tue, 03 Nov 2020 11:00:20 +0100, Vincent Whitchurch wrote:
> > Add bindings for the Dialog Semiconductor DA9121 voltage regulator.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  .../bindings/regulator/dlg,da9121.yaml        | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: ignoring, error in schema: 
> warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> 
> See https://patchwork.ozlabs.org/patch/1392753

OK, thanks.  I'll fix it by changing the unevaluatedProperties to an
additionalProperties (since the $ref has moved).  

I think I should also move the unevaluatedProperties to the buck1 level
instead of removing it completely, because I see a bunch of other
regulator bindings doing it, but the checks don't complain about that
being missing and I can't see that making any difference for the
validation.

For example, I was hoping that this:

  buck1:
    description:
      Initial data for the Buck1 regulator.
    $ref: "regulator.yaml#"
    type: object
    unevaluatedProperties: false

would complain about something like:

        buck1 {
	  not-a-real-property;
          regulator-min-microvolt = <680000>;
          regulator-max-microvolt = <820000>;
        };

but it doesn't, so I don't quite understand what "unevaluatedProperties:
false" prevents.

> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade

Not sure if it's just something wrong in my setup, but I had dtschema
installed from master a while ago, and the above command didn't upgrade
it for me.  I had to explicitly upgrade it with the full URL again to
get the latest version:

 pip3 install --upgrade git+https://github.com/devicetree-org/dt-schema.git@master
